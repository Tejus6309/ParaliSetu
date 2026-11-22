import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';
import 'generated/protocol.dart';

class DemoData {
  static String hashPassword(String password) {
    return sha256.convert(utf8.encode('paralisetu_salt_$password')).toString();
  }

  static Future<void> seedIfEmpty(Session session) async {
    try {
      // Check if users already seeded
      var existing = await ParaliUser.db.find(
        session,
        where: (t) => t.email.equals('farmer@demo.paralisetu.org'),
        limit: 1,
      );

      if (existing.isNotEmpty) return;

      session.log('Seeding ParaliSetu initial demo data...');
      final password = 'ParaliDemo123!';
      final passwordHash = hashPassword(password);

      final farmer = ParaliUser(
        email: 'farmer@demo.paralisetu.org',
        name: 'Gurpreet Singh',
        role: 'FARMER',
        passwordHash: passwordHash,
        createdAt: DateTime.now(),
      );
      final buyer = ParaliUser(
        email: 'buyer@demo.paralisetu.org',
        name: 'GreenField Biomass',
        role: 'BUYER',
        passwordHash: passwordHash,
        createdAt: DateTime.now(),
      );
      final logistics = ParaliUser(
        email: 'logistics@demo.paralisetu.org',
        name: 'Punjab Rural Transport',
        role: 'LOGISTICS',
        passwordHash: passwordHash,
        createdAt: DateTime.now(),
      );
      final admin = ParaliUser(
        email: 'admin@demo.paralisetu.org',
        name: 'ParaliSetu Moderator',
        role: 'ADMIN',
        passwordHash: passwordHash,
        createdAt: DateTime.now(),
      );

      final insertedFarmer = await ParaliUser.db.insertRow(session, farmer);
      final insertedBuyer = await ParaliUser.db.insertRow(session, buyer);
      final insertedLogistics = await ParaliUser.db.insertRow(session, logistics);
      await ParaliUser.db.insertRow(session, admin);

      final farmerId = insertedFarmer.id ?? 1;
      final buyerId = insertedBuyer.id ?? 2;
      final logisticsId = insertedLogistics.id ?? 3;

      final now = DateTime.now();
      final listings = [
        ParaliListing(
          farmerId: farmerId,
          farmerName: insertedFarmer.name,
          crop: 'Rice straw',
          district: 'Ludhiana',
          description: 'Dry, baled paddy straw ready for pickup.',
          availableKg: 2400,
          pricePerKg: 2.40,
          harvestDate: now.subtract(const Duration(days: 14)),
          availableFrom: now.subtract(const Duration(days: 7)),
          availableUntil: now.add(const Duration(days: 365)),
          status: 'ACTIVE',
          version: 0,
        ),
        ParaliListing(
          farmerId: farmerId,
          farmerName: insertedFarmer.name,
          crop: 'Wheat straw',
          district: 'Patiala',
          description: 'Stored under cover. Tractor access available.',
          availableKg: 1500,
          pricePerKg: 3.10,
          harvestDate: now.subtract(const Duration(days: 14)),
          availableFrom: now.subtract(const Duration(days: 7)),
          availableUntil: now.add(const Duration(days: 365)),
          status: 'ACTIVE',
          version: 0,
        ),
        ParaliListing(
          farmerId: farmerId,
          farmerName: insertedFarmer.name,
          crop: 'Rice straw',
          district: 'Sangrur',
          description: 'Loose straw collected after harvest.',
          availableKg: 850,
          pricePerKg: 2.20,
          harvestDate: now.subtract(const Duration(days: 14)),
          availableFrom: now.subtract(const Duration(days: 7)),
          availableUntil: now.add(const Duration(days: 365)),
          status: 'ACTIVE',
          version: 0,
        ),
        ParaliListing(
          farmerId: farmerId,
          farmerName: insertedFarmer.name,
          crop: 'Maize stalks',
          district: 'Bathinda',
          description: 'Bundled stalks from the autumn harvest.',
          availableKg: 1200,
          pricePerKg: 2.70,
          harvestDate: now.subtract(const Duration(days: 14)),
          availableFrom: now.subtract(const Duration(days: 7)),
          availableUntil: now.add(const Duration(days: 365)),
          status: 'ACTIVE',
          version: 0,
        ),
      ];

      ParaliListing? firstListing;
      for (final l in listings) {
        final inserted = await ParaliListing.db.insertRow(session, l);
        firstListing ??= inserted;
      }

      if (firstListing != null) {
        await ParaliOrder.db.insertRow(
          session,
          ParaliOrder(
            listingId: firstListing.id ?? 1,
            farmerId: farmerId,
            buyerId: buyerId,
            carrierId: logisticsId,
            quantityKg: 350,
            pricePerKg: 2.40,
            crop: 'Rice straw',
            district: 'Ludhiana',
            status: 'DELIVERED',
            farmerName: insertedFarmer.name,
            buyerName: insertedBuyer.name,
            carrierName: insertedLogistics.name,
            farmerArrivedAt: now.subtract(const Duration(days: 2)),
            carrierArrivedAt: now.subtract(const Duration(days: 2)),
            createdAt: now.subtract(const Duration(days: 3)),
          ),
        );
      }

      session.log('ParaliSetu demo data successfully seeded.');
    } catch (e, st) {
      session.log('Notice: Demo seeding skipped or completed: $e', level: LogLevel.warning, exception: e, stackTrace: st);
    }
  }
}
