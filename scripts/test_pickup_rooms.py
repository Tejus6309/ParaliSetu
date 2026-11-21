"""Run against a seeded server using DEMO_BASE_URL. Leaves a picked-up test order."""
from smoke import call, login
from datetime import date, timedelta
from uuid import uuid4

def create_assigned():
    farmer, buyer, carrier = map(login, ("farmer","buyer","logistics"))
    district = "Pickup-" + uuid4().hex[:8]
    today = date.today()
    call(farmer,"/farmer/listings","POST", {
        "crop":"Rice straw","district":district,"description":"Test pickup lot",
        "availableKg":50,"pricePerKg":2,"harvestDate":str(today),
        "availableFrom":str(today),"availableUntil":str(today + timedelta(days=10))
    },201)
    listing = call(buyer,"/listings?district=" + district)[1][0]
    call(buyer,"/orders","POST",{"listingId":listing["id"],"quantityKg":10},201)
    order = next(o for o in call(farmer,"/orders")[1] if o["district"] == district)
    path = "/orders/" + str(order["id"])
    call(farmer,path,"PATCH",{"action":"ACCEPT"},204)
    call(farmer,path,"PATCH",{"action":"ASSIGN","carrierId":call(carrier,"/auth/me")[1]["id"]},204)
    return farmer,buyer,carrier,path

if __name__ == "__main__":
    farmer,buyer,carrier,path = create_assigned()
    room = path + "/pickup-room"
    call(buyer,room,expected=403)
    assert call(carrier,room)[1]["farmer_arrived_at"] is None
    first = call(farmer,room+"/arrive","POST")[1]["farmer_arrived_at"]
    assert first and call(farmer,room+"/arrive","POST")[1]["farmer_arrived_at"] == first
    assert call(carrier,room)[1]["farmer_arrived_at"] == first
    call(carrier,room+"/arrive","POST")
    assert call(farmer,room)[1]["carrier_arrived_at"]
    call(carrier,path,"PATCH",{"action":"PICK_UP"},204)
    call(carrier,room+"/arrive","POST",expected=409)
    print("Passed two-session check-in, retry, access and closure tests.")
