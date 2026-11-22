import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import 'auth_endpoint.dart';

class InsightsEndpoint extends Endpoint {
  static MatchResult rankListing(ParaliListing listing, String preferredDistrict, double? maxPrice) {
    final reasons = <String>[
      'Crop matches (+50)',
      'Enough stock (+25)',
    ];

    final isLocal = listing.district.trim().toLowerCase() == preferredDistrict.trim().toLowerCase();
    final withinBudget = maxPrice != null && listing.pricePerKg <= maxPrice;

    reasons.add(isLocal ? 'Preferred district (+15)' : 'Different district (+0)');
    if (maxPrice != null) {
      reasons.add(withinBudget ? 'Within budget (+10)' : 'Above budget (+0)');
    }

    final score = 75 + (isLocal ? 15 : 0) + (withinBudget ? 10 : 0);
    return MatchResult(listing: listing, score: score, reasons: reasons);
  }

  Future<List<MatchResult>> matches(
    Session session, {
    required String crop,
    required String district,
    required int quantityKg,
    double? maxPrice,
  }) async {
    if (crop.trim().isEmpty || district.trim().isEmpty || quantityKg <= 0 || (maxPrice != null && maxPrice <= 0)) {
      throw EndpointException(
        message: 'Enter a crop, district, positive quantity and optional positive price.',
        errorType: EndpointExceptionType.badRequest,
      );
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final candidates = await ParaliListing.db.find(
      session,
      where: (t) =>
          t.status.equals('ACTIVE') &
          (t.availableUntil >= today) &
          (t.availableKg >= quantityKg),
    );

    final cleanCrop = crop.trim().toLowerCase();
    final matchingCrop = candidates.where((l) => l.crop.toLowerCase() == cleanCrop).toList();

    final results = matchingCrop.map((l) => rankListing(l, district, maxPrice)).toList();

    results.sort((a, b) {
      final scoreCompare = b.score.compareTo(a.score);
      if (scoreCompare != 0) return scoreCompare;
      final priceCompare = a.listing.pricePerKg.compareTo(b.listing.pricePerKg);
      if (priceCompare != 0) return priceCompare;
      return (b.listing.id ?? 0).compareTo(a.listing.id ?? 0);
    });

    return results.take(20).toList();
  }

  Future<ImpactStats> impact(Session session) async {
    final deliveredOrders = await ParaliOrder.db.find(
      session,
      where: (t) => t.status.equals('DELIVERED'),
    );

    final deliveries = deliveredOrders.length;
    int deliveredKg = 0;
    final cropTotals = <String, int>{};

    for (final order in deliveredOrders) {
      deliveredKg += order.quantityKg;
      cropTotals[order.crop] = (cropTotals[order.crop] ?? 0) + order.quantityKg;
    }

    final byCrop = cropTotals.entries
        .map((e) => CropDelivery(crop: e.key, deliveredKg: e.value))
        .toList()
      ..sort((a, b) => a.crop.compareTo(b.crop));

    return ImpactStats(
      deliveries: deliveries,
      deliveredKg: deliveredKg,
      estimatedDivertedKg: deliveredKg,
      byCrop: byCrop,
      caveat: 'Demo estimate assumes all delivered residue would otherwise have been burned. '
          'This counterfactual is unverified. The estimate does not measure avoided emissions or certify carbon credits.',
    );
  }
}
