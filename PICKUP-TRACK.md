# Track 1 — Here, together

Merge this patch into the latest ParaliSetu JDBC repository. The rebuilt JAR includes the React pickup room and preserves the full-page sign-in design. Start from the repository root with Java 21+:

    java -jar app/paralisetu.jar

## Two-device demo

On a trusted private Wi-Fi network, run the following command on one laptop to make its local demo reachable from phones:

    java -jar app/paralisetu.jar --server.address=0.0.0.0

Open http://LAPTOP-LAN-IP:8080 on both devices. Use separate browser profiles if demonstrating on one computer. All clients must connect to the same running server. The default demo password is ParaliDemo123!.

1. As buyer@demo.paralisetu.org, request 500 kg from an active rice straw listing.
2. As farmer@demo.paralisetu.org, accept, then assign Punjab Rural Transport.
3. On device A, open Requests & orders → Open pickup room. On device B, sign in as logistics@demo.paralisetu.org and open the same room under Delivery assignments.
4. Each participant taps **I am at the pickup site**. Both screens refresh every two seconds. Check-ins survive a reload or server restart. Repeated taps preserve the first check-in timestamp.
5. The transporter marks the order picked up using the existing order controls. The room closes for check-in. A check-in is a self-report of arrival, separate from physical collection and delivery.

## Implementation

The assigned order identifies the room. The Java API authenticates each device and checks order membership. React and Flutter clients read the same room via GET /api/orders/{id}/pickup-room and check in via POST /api/orders/{id}/pickup-room/arrive with X-Parali-Client: 1. Flyway adds two nullable timestamps to existing orders. Migrations are included for embedded H2 and MySQL.

## Flutter web companion

The ready-to-run JAR serves the React experience. The optional Flutter client uses the same authenticated session when hosted on the Java application's origin. With a Flutter SDK supporting Dart 3.4 or later, run from pickup_flutter:

    flutter pub get
    flutter build web --base-href /pickup/

Copy the contents of pickup_flutter/build/web into frontend/dist/pickup/ **after** building the React frontend. Then run from the repository root:

    mvn -f backend/pom.xml clean verify
    java -jar backend/target/paralisetu-0.1.0.jar

Sign in through the main app, then open /pickup/index.html in the same browser. The Flutter client shares the existing Java/JDBC backend. Serverpod Cloud is not integrated.

## Verification

With the demo running, set DEMO_BASE_URL to its origin, for example http://localhost:8080. Run python scripts/test_pickup_rooms.py. This exercises separate farmer, logistics, and buyer sessions and creates a small test order.
