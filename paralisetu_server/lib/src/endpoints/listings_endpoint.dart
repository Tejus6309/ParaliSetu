import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import 'auth_endpoint.dart';

class ListingsEndpoint extends Endpoint {
  Future<List<ParaliListing>> browse(
    Session session, {
    String? q,
    String? crop,
    String? district,
    int minKg = 1,
    int offset = 0,
    DateTime? harvestAfter,
  }) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    var listings = await ParaliListing.db.find(
      session,
      where: (t) =>
          t.status.equals('ACTIVE') &
          (t.availableUntil >= today) &
          (t.availableKg >= minKg),
      orderByList: (t) => [t.id.desc()],
      limit: 100,
      offset: offset,
    );

    // Apply in-memory text search and date filters if provided
    if (harvestAfter != null) {
      listings = listings.where((l) => !l.harvestDate.isBefore(harvestAfter)).toList();
    }
    if (crop != null && crop.trim().isNotEmpty) {
      final cleanCrop = crop.trim().toLowerCase();
      listings = listings.where((l) => l.crop.toLowerCase() == cleanCrop).toList();
    }
    if (district != null && district.trim().isNotEmpty) {
      final cleanDistrict = district.trim().toLowerCase();
      listings = listings.where((l) => l.district.toLowerCase() == cleanDistrict).toList();
    }
    if (q != null && q.trim().isNotEmpty) {
      final query = q.trim().toLowerCase();
      listings = listings.where((l) {
        final haystack = '${l.crop} ${l.district} ${l.description} ${l.farmerName ?? ''}'.toLowerCase();
        return haystack.contains(query);
      }).toList();
    }

    return listings;
  }

  Future<ParaliListing> detail(
    Session session,
    int id, {
    int? viewerUserId,
    String? viewerRole,
  }) async {
    final listing = await ParaliListing.db.findById(session, id);
    if (listing == null || listing.status == 'DELETED') {
      throw EndpointException(message: 'Listing not found.', errorType: EndpointExceptionType.notFound);
    }

    final isFarmerOwner = viewerUserId != null && listing.farmerId == viewerUserId;
    final isAdmin = viewerRole == 'ADMIN';
    final isPubliclyActive = listing.status == 'ACTIVE' && !listing.availableUntil.isBefore(DateTime.now());

    if (!isPubliclyActive && !isFarmerOwner && !isAdmin) {
      throw EndpointException(message: 'Listing not found.', errorType: EndpointExceptionType.notFound);
    }

    return listing;
  }

  Future<List<ParaliListing>> farmerListings(Session session, int farmerId) async {
    return await ParaliListing.db.find(
      session,
      where: (t) => t.farmerId.equals(farmerId) & t.status.notEquals('DELETED'),
      orderByList: (t) => [t.id.desc()],
    );
  }

  Future<ParaliListing> create(
    Session session, {
    required int farmerId,
    required String farmerName,
    required String crop,
    required String district,
    required String description,
    required int availableKg,
    required double pricePerKg,
    required DateTime harvestDate,
    required DateTime availableFrom,
    required DateTime availableUntil,
  }) async {
    _validateDates(harvestDate, availableFrom, availableUntil);

    final listing = ParaliListing(
      farmerId: farmerId,
      farmerName: farmerName,
      crop: crop.trim(),
      district: district.trim(),
      description: description.trim(),
      availableKg: availableKg,
      pricePerKg: pricePerKg,
      harvestDate: harvestDate,
      availableFrom: availableFrom,
      availableUntil: availableUntil,
      status: 'ACTIVE',
      version: 0,
    );

    return await ParaliListing.db.insertRow(session, listing);
  }

  Future<ParaliListing> edit(
    Session session, {
    required int farmerId,
    required int id,
    required int version,
    required String crop,
    required String district,
    required String description,
    required int availableKg,
    required double pricePerKg,
    required DateTime harvestDate,
    required DateTime availableFrom,
    required DateTime availableUntil,
  }) async {
    _validateDates(harvestDate, availableFrom, availableUntil);

    final listing = await ParaliListing.db.findById(session, id);
    if (listing == null || listing.farmerId != farmerId || !['ACTIVE', 'PAUSED'].contains(listing.status)) {
      throw EndpointException(message: 'Listing not found or unavailable for editing.', errorType: EndpointExceptionType.notFound);
    }

    if (listing.version != version) {
      throw EndpointException(
        message: 'The listing changed. Close the editor and reopen the latest listing.',
        errorType: EndpointExceptionType.conflict,
      );
    }

    final updated = listing.copyWith(
      crop: crop.trim(),
      district: district.trim(),
      description: description.trim(),
      availableKg: availableKg,
      pricePerKg: pricePerKg,
      harvestDate: harvestDate,
      availableFrom: availableFrom,
      availableUntil: availableUntil,
      version: version + 1,
    );

    return await ParaliListing.db.updateRow(session, updated);
  }

  Future<void> status(Session session, int farmerId, int id, String newStatus) async {
    final cleanStatus = newStatus.trim().toUpperCase();
    if (!['ACTIVE', 'PAUSED'].contains(cleanStatus)) {
      throw EndpointException(message: 'Choose ACTIVE or PAUSED.', errorType: EndpointExceptionType.badRequest);
    }

    final listing = await ParaliListing.db.findById(session, id);
    if (listing == null || listing.farmerId != farmerId || !['ACTIVE', 'PAUSED'].contains(listing.status)) {
      throw EndpointException(message: 'Listing not found or unavailable for this action.', errorType: EndpointExceptionType.notFound);
    }

    await ParaliListing.db.updateRow(session, listing.copyWith(status: cleanStatus));
  }

  Future<void> delete(Session session, int farmerId, int id) async {
    final listing = await ParaliListing.db.findById(session, id);
    if (listing == null || listing.farmerId != farmerId || listing.status == 'DELETED') {
      throw EndpointException(message: 'Listing not found.', errorType: EndpointExceptionType.notFound);
    }

    await ParaliListing.db.updateRow(session, listing.copyWith(status: 'DELETED'));
  }

  Future<List<ParaliListing>> adminListings(Session session) async {
    return await ParaliListing.db.find(
      session,
      where: (t) => t.status.notEquals('DELETED'),
      orderByList: (t) => [t.id.desc()],
    );
  }

  Future<void> moderate(Session session, int id, String newStatus) async {
    final clean = newStatus.trim().toUpperCase();
    if (!['REMOVED', 'PAUSED'].contains(clean)) {
      throw EndpointException(message: 'Choose REMOVED or PAUSED.', errorType: EndpointExceptionType.badRequest);
    }

    final listing = await ParaliListing.db.findById(session, id);
    if (listing == null) {
      throw EndpointException(message: 'Listing not found.', errorType: EndpointExceptionType.notFound);
    }

    await ParaliListing.db.updateRow(session, listing.copyWith(status: clean));
  }

  void _validateDates(DateTime harvestDate, DateTime availableFrom, DateTime availableUntil) {
    if (harvestDate.isAfter(availableFrom) || availableFrom.isAfter(availableUntil)) {
      throw EndpointException(
        message: 'Use valid dates in harvest, available from, available until order.',
        errorType: EndpointExceptionType.badRequest,
      );
    }
  }
}
