import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants.dart';
import '../../providers/listings_provider.dart';
import '../../widgets/error_banner.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/listing_card.dart';
import 'listing_detail_screen.dart';

class MarketplaceScreen extends ConsumerStatefulWidget {
  const MarketplaceScreen({super.key});

  @override
  ConsumerState<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends ConsumerState<MarketplaceScreen> {
  final _searchController = TextEditingController();
  final _cropController = TextEditingController();
  final _districtController = TextEditingController();
  final _minKgController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    _cropController.dispose();
    _districtController.dispose();
    _minKgController.dispose();
    super.dispose();
  }

  void _applyFilters() {
    final minKg = int.tryParse(_minKgController.text.trim()) ?? 1;
    ref.read(listingsFilterProvider.notifier).state = ListingsFilter(
      query: _searchController.text.trim().isEmpty ? null : _searchController.text.trim(),
      crop: _cropController.text.trim().isEmpty ? null : _cropController.text.trim(),
      district: _districtController.text.trim().isEmpty ? null : _districtController.text.trim(),
      minKg: minKg,
    );
  }

  @override
  Widget build(BuildContext context) {
    final listingsAsync = ref.watch(browseListingsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        onRefresh: () async => ref.refresh(browseListingsProvider.future),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Page Heading
            const Text(
              'Residue Marketplace',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 4),
            const Text(
              'Browse available crop residue lots from local farmers across Punjab & Haryana.',
              style: TextStyle(color: AppColors.textMuted, fontSize: 13),
            ),
            const SizedBox(height: 16),

            // Filter Glass Container
            GlassContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search crop, district or farmer name...',
                      prefixIcon: Icon(Icons.search, size: 20),
                    ),
                    onSubmitted: (_) => _applyFilters(),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _cropController,
                          decoration: const InputDecoration(
                            hintText: 'Crop (e.g. Rice straw)',
                          ),
                          onSubmitted: (_) => _applyFilters(),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _districtController,
                          decoration: const InputDecoration(
                            hintText: 'District (e.g. Ludhiana)',
                          ),
                          onSubmitted: (_) => _applyFilters(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _minKgController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Min quantity (kg)',
                          ),
                          onSubmitted: (_) => _applyFilters(),
                        ),
                      ),
                      const SizedBox(width: 10),
                      FilledButton.icon(
                        icon: const Icon(Icons.filter_list, size: 18),
                        label: const Text('Filter'),
                        onPressed: _applyFilters,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Listings List
            listingsAsync.when(
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: CircularProgressIndicator(color: AppColors.brandGreen),
                ),
              ),
              error: (err, _) => ErrorBanner(message: err.toString()),
              data: (listings) {
                if (listings.isEmpty) {
                  return const GlassContainer(
                    padding: EdgeInsets.all(32),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(Icons.inventory_2_outlined, size: 48, color: AppColors.textMuted),
                          SizedBox(height: 12),
                          Text(
                            'No residue listings match those criteria.',
                            style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textMuted),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${listings.length} lots available',
                      style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 10),
                    for (final listing in listings)
                      ListingCard(
                        listing: listing,
                        trailingAction: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FilledButton.tonal(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => ListingDetailScreen(listingId: listing.id!),
                                  ),
                                );
                              },
                              child: const Text('View & Request'),
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
