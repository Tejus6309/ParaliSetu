import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paralisetu_client/paralisetu_client.dart';
import '../../core/client.dart';
import '../../core/constants.dart';
import '../../widgets/error_banner.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/listing_card.dart';
import '../marketplace/listing_detail_screen.dart';

class MatchingScreen extends ConsumerStatefulWidget {
  const MatchingScreen({super.key});

  @override
  ConsumerState<MatchingScreen> createState() => _MatchingScreenState();
}

class _MatchingScreenState extends ConsumerState<MatchingScreen> {
  final _cropController = TextEditingController(text: 'Rice straw');
  final _districtController = TextEditingController(text: 'Ludhiana');
  final _quantityController = TextEditingController(text: '500');
  final _budgetController = TextEditingController();

  bool _isSearching = false;
  List<MatchResult>? _matches;
  String? _error;

  @override
  void dispose() {
    _cropController.dispose();
    _districtController.dispose();
    _quantityController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  void _findMatches() async {
    final crop = _cropController.text.trim();
    final district = _districtController.text.trim();
    final qty = int.tryParse(_quantityController.text.trim()) ?? 0;
    final budget = double.tryParse(_budgetController.text.trim());

    if (crop.isEmpty || district.isEmpty || qty <= 0) {
      setState(() => _error = 'Please enter crop, preferred district, and quantity needed.');
      return;
    }

    setState(() { _isSearching = true; _error = null; });

    try {
      final client = ref.read(clientProvider);
      final results = await client.insights.matches(
        crop: crop,
        district: district,
        quantityKg: qty,
        maxPrice: budget,
      );
      if (mounted) setState(() { _matches = results; _isSearching = false; });
    } catch (e) {
      if (mounted) setState(() { _error = e.toString(); _isSearching = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Find Matching Supply',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 4),
          const Text(
            'Smart scoring ranks listings by crop fit (+50), stock adequacy (+25), district proximity (+15), and budget (+10).',
            style: TextStyle(color: AppColors.textMuted, fontSize: 13),
          ),
          const SizedBox(height: 16),

          // Matching Query Form
          GlassContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _cropController,
                  decoration: const InputDecoration(
                    labelText: 'Crop type required',
                    hintText: 'e.g. Rice straw',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _districtController,
                  decoration: const InputDecoration(
                    labelText: 'Preferred local district',
                    hintText: 'e.g. Ludhiana',
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _quantityController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Quantity needed (kg)',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _budgetController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(
                          labelText: 'Budget per kg (₹)',
                          hintText: 'Optional',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                FilledButton.icon(
                  onPressed: _isSearching ? null : _findMatches,
                  icon: const Icon(Icons.auto_awesome, size: 18),
                  label: _isSearching
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Text('Calculate Supply Matches'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          if (_error != null)
            ErrorBanner(
              message: _error,
              onDismiss: () => setState(() => _error = null),
            ),

          if (_matches != null) ...[
            Text(
              '${_matches!.length} ranked matches',
              style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 10),
            if (_matches!.isEmpty)
              const GlassContainer(
                padding: EdgeInsets.all(32),
                child: Center(
                  child: Text(
                    'No listings meet your required crop and quantity.',
                    style: TextStyle(color: AppColors.textMuted),
                  ),
                ),
              )
            else
              for (final match in _matches!)
                ListingCard(
                  listing: match.listing,
                  match: match,
                  trailingAction: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FilledButton.tonal(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ListingDetailScreen(listingId: match.listing.id!),
                            ),
                          );
                        },
                        child: const Text('View & Request'),
                      ),
                    ],
                  ),
                ),
          ],
        ],
      ),
    );
  }
}
