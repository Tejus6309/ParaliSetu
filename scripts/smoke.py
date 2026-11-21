"""Run against a local seeded instance. Creates a listing and a delivered test order."""
from concurrent.futures import ThreadPoolExecutor
from datetime import date, timedelta
from http.cookiejar import CookieJar
from json import dumps, loads
import os
from urllib.error import HTTPError
from urllib.request import HTTPCookieProcessor, Request, build_opener
from uuid import uuid4

BASE = os.getenv("DEMO_BASE_URL", "http://localhost:5173") + "/api"
PASSWORD = os.getenv("DEMO_PASSWORD", "ParaliDemo123!")


def call(client, path, method="GET", payload=None, expected=200, send_header=True):
    headers = {"Content-Type": "application/json"}
    if send_header:
        headers["X-Parali-Client"] = "1"
    body = dumps(payload).encode() if payload is not None else None
    request = Request(BASE + path, data=body, headers=headers, method=method)
    try:
        with client.open(request, timeout=15) as response:
            status, data = response.status, response.read()
    except HTTPError as error:
        status, data = error.code, error.read()
    expected_codes = expected if isinstance(expected, tuple) else (expected,)
    if status not in expected_codes:
        raise AssertionError(f"{method} {path}: got {status}, expected {expected}; {data!r}")
    return status, loads(data) if data else None


def login(role):
    client = build_opener(HTTPCookieProcessor(CookieJar()))
    _, user = call(client, "/auth/login", "POST",
                   {"email": f"{role}@demo.paralisetu.org", "password": PASSWORD})
    assert user["role"] == role.upper()
    return client


def main():
    anonymous = build_opener()
    call(anonymous, "/health")
    call(anonymous, "/auth/me", expected=401)
    call(anonymous, "/auth/logout", "POST", expected=403, send_header=False)
    call(anonymous, "/auth/register", "POST",
         {"name": "Invalid", "email": "invalid@example.org", "password": PASSWORD, "role": "ADMIN"}, 400)
    farmer, buyer, carrier, admin = map(login, ("farmer", "buyer", "logistics", "admin"))
    call(buyer, "/admin/listings", expected=403)
    call(buyer, "/orders", "POST", {"quantityKg": 0}, 400)
    _, baseline = call(admin, "/impact")

    today = date.today()
    district = "Smoke " + uuid4().hex[:8]
    fields = {"crop": "Rice straw", "district": district, "description": "Baled demo residue",
              "availableKg": 700, "pricePerKg": 2.50, "harvestDate": today.isoformat(),
              "availableFrom": today.isoformat(), "availableUntil": (today + timedelta(days=14)).isoformat()}
    call(farmer, "/farmer/listings", "POST", fields, 201)
    _, matches = call(buyer, f"/matches?crop=Rice%20straw&district={district.replace(' ', '%20')}&quantityKg=500&maxPrice=3")
    assert matches[0]["score"] == 100
    listing = matches[0]["listing"]
    lid = listing["id"]
    _, search = call(buyer, f"/listings?q={district.replace(' ', '%20')}&crop=Rice%20straw&minKg=500&harvestAfter={today}")
    assert [row["id"] for row in search] == [lid]
    listing_path = f"/listings/{lid}"
    edit_path = f"/farmer/listings/{lid}"
    call(farmer, edit_path, "PUT", {**fields, "version": listing["version"]}, 204)

    for _ in range(2):
        call(buyer, "/orders", "POST", {"listingId": lid, "quantityKg": 500}, 201)
    _, visible_orders = call(farmer, "/orders")
    first, second = [o["id"] for o in visible_orders if o["listing_id"] == lid]

    def accept(order):
        return call(login("farmer"), f"/orders/{order}", "PATCH", {"action": "ACCEPT"}, (204, 409))[0]

    with ThreadPoolExecutor(max_workers=2) as pool:
        statuses = list(pool.map(accept, (first, second)))
    assert sorted(statuses) == [204, 409], statuses
    accepted, rejected = (first, second) if statuses[0] == 204 else (second, first)
    call(farmer, edit_path, "PUT", {**fields, "version": listing["version"] + 1}, 409)
    _, listing = call(buyer, listing_path)
    assert listing["available_kg"] == 200
    call(buyer, f"/orders/{accepted}", "PATCH", {"action": "CANCEL"}, 204)
    _, listing = call(buyer, listing_path)
    assert listing["available_kg"] == 700

    order_path = f"/orders/{rejected}"
    call(farmer, order_path, "PATCH", {"action": "ACCEPT"}, 204)
    call(carrier, order_path, "PATCH", {"action": "PICK_UP"}, 404)
    _, carriers = call(farmer, "/carriers")
    _, carrier_identity = call(carrier, "/auth/me")
    assert carrier_identity["id"] in {row["id"] for row in carriers}
    call(farmer, order_path, "PATCH", {"action": "ASSIGN", "carrierId": carrier_identity["id"]}, 204)
    call(carrier, order_path, "PATCH", {"action": "PICK_UP"}, 204)
    call(buyer, order_path, "PATCH", {"action": "CANCEL"}, 409)
    call(carrier, order_path, "PATCH", {"action": "DELIVER"}, 204)
    _, impact = call(admin, "/impact")
    assert impact["delivered_kg"] == baseline["delivered_kg"] + 500
    assert impact["deliveries"] == baseline["deliveries"] + 1

    moderation = f"/admin/listings/{lid}/status"
    call(admin, moderation, "PATCH", {"status": "REMOVED"}, 204)
    call(buyer, listing_path, expected=404)
    call(farmer, edit_path + "/status", "PATCH", {"status": "ACTIVE"}, 404)
    call(admin, moderation, "PATCH", {"status": "PAUSED"}, 204)
    call(farmer, edit_path + "/status", "PATCH", {"status": "ACTIVE"}, 204)
    call(buyer, listing_path)
    call(farmer, edit_path, "DELETE", expected=204)
    call(buyer, listing_path, expected=404)
    call(buyer, "/auth/logout", "POST", expected=204)
    call(buyer, "/auth/me", expected=401)
    print("Passed: access control, validation, listing edit, matching, overlapping reservations, "
          "cancellation, delivery, impact, moderation, deletion and logout.")


if __name__ == "__main__":
    main()
