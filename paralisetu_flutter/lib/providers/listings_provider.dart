import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paralisetu_client/paralisetu_client.dart';
import '../core/client.dart';
import 'auth_provider.dart';

class ListingsFilter {
  final String? query;
  final String? crop;
  final String? district;
  final int minKg;
  final DateTime? harvestAfter;

  const ListingsFilter({
    this.query,
    this.crop,
    this.district,
    this.minKg = 1,
    this.harvestAfter,
  });

  ListingsFilter copyWith({
    String? query,
    String? crop,
    String? district,
    int? minKg,
    DateTime? harvestAfter,
    bool clearQuery = false,
  }) {
    return ListingsFilter(
      query: clearQuery ? null : (query ?? this.query),
      crop: crop ?? this.crop,
      district: district ?? this.district,
      minKg: minKg ?? this.minKg,
      harvestAfter: harvestAfter ?? this.harvestAfter,
    );
  }
}

final listingsFilterProvider = StateProvider<ListingsFilter>((ref) {
  return const ListingsFilter();
});

final browseListingsProvider = FutureProvider.autoDispose<List<ParaliListing>>((ref) async {
  final client = ref.watch(clientProvider);
  final filter = ref.watch(listingsFilterProvider);

  return client.listings.browse(
    q: filter.query,
    crop: filter.crop,
    district: filter.district,
    minKg: filter.minKg,
    harvestAfter: filter.harvestAfter,
  );
});

final farmerListingsProvider = FutureProvider.autoDispose<List<ParaliListing>>((ref) async {
  final client = ref.watch(clientProvider);
  final auth = ref.watch(authProvider);

  final user = auth.user;
  if (user == null || user.id == null) return [];

  return client.listings.farmerListings(user.id!);
});

final adminListingsProvider = FutureProvider.autoDispose<List<ParaliListing>>((ref) async {
  final client = ref.watch(clientProvider);
  return client.listings.adminListings();
});
