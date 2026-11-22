import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paralisetu_client/paralisetu_client.dart';
import '../../core/client.dart';
import '../../core/constants.dart';
import '../../core/formatters.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/error_banner.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/listing_card.dart';

class ListingDetailScreen extends ConsumerStatefulWidget {
  final int listingId;

  const ListingDetailScreen({super.key, required this.listingId});

  @override
  ConsumerState<ListingDetailScreen> createState() => _ListingDetailScreenState();
}

class _ListingDetailScreenState extends ConsumerState<ListingDetailScreen> {
  final _quantityController = TextEditingController();
  bool _isLoading = true;
  bool _isSubmitting = false;
  ParaliListing? _listing;
  String? _error;
  bool _orderSent = false;

  @override
  void initState() {
    super.initState();
    _loadDetail();
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  void _loadDetail() async {
    final client = ref.read(clientProvider);
    final auth = ref.read(authProvider);

    try {
      final item = await client.listings.detail(
        widget.listingId,
        viewerUserId: auth.user?.id,
        viewerRole: auth.user?.role,
      );
      if (mounted) setState(() { _listing = item; _isLoading = false; });
    } catch (e) {
      if (mounted) setState(() { _error = e.toString(); _isLoading = false; });
    }
  }

  void _submitOrder() async {
    final qty = int.tryParse(_quantityController.text.trim());
    if (qty == null || qty <= 0) {
      setState(() => _error = 'Enter a valid positive quantity.');
      return;
    }

    if (_listing != null && qty > _listing!.availableKg) {
      setState(() => _error = 'Cannot request more than the available stock (${_listing!.availableKg} kg).');
      return;
    }

    final client = ref.read(clientProvider);
    final user = ref.read(authProvider).user;
    if (user == null || user.id == null) {
      setState(() => _error = 'Please sign in to place an order.');
      return;
    }

    setState(() { _isSubmitting = true; _error = null; });

    try {
      await client.orders.requestOrder(
        buyerId: user.id!,
        buyerName: user.name,
        listingId: widget.listingId,
        quantityKg: qty,
      );
      if (mounted) setState(() { _isSubmitting = false; _orderSent = true; });
    } catch (e) {
      if (mounted) setState(() { _isSubmitting = false; _error = e.toString(); });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userRole = ref.watch(authProvider).user?.role ?? '';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(_listing?.crop ?? 'Listing Details'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.brandGreen))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_error != null)
                    ErrorBanner(
                      message: _error,
                      onDismiss: () => setState(() => _error = null),
                    ),

                  if (_listing != null) ...[
                    ListingCard(listing: _listing!),
                    const SizedBox(height: 16),

                    // Purchase Request Section (visible for buyers)
                    if (userRole == 'BUYER')
                      GlassContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Purchase Request',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Stock is officially reserved once the farmer accepts your request.',
                              style: TextStyle(color: AppColors.textMuted, fontSize: 13),
                            ),
                            const SizedBox(height: 16),

                            if (_orderSent) ...[
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColors.activeGreenBg,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.check_circle, color: AppColors.activeGreen),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        'Purchase request submitted successfully! Track status in My Orders.',
                                        style: TextStyle(color: AppColors.activeGreen, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ] else if (_listing!.availableKg <= 0) ...[
                              const Text('This lot is sold out or unavailable.', style: TextStyle(color: AppColors.dangerRed)),
                            ] else ...[
                              TextField(
                                controller: _quantityController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Quantity needed (kg)',
                                  hintText: 'Max ${_listing!.availableKg} kg',
                                  suffixText: 'kg',
                                ),
                                onChanged: (_) => setState(() {}),
                              ),
                              const SizedBox(height: 10),
                              if (int.tryParse(_quantityController.text) != null) ...[
                                Text(
                                  'Estimated total: ${Formatters.money((int.tryParse(_quantityController.text)! * _listing!.pricePerKg))}',
                                  style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.brandGreen, fontSize: 14),
                                ),
                                const SizedBox(height: 12),
                              ],
                              FilledButton(
                                onPressed: _isSubmitting ? null : _submitOrder,
                                child: _isSubmitting
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                      )
                                    : const Text('Send Purchase Request'),
                              ),
                            ],
                          ],
                        ),
                      )
                    else if (userRole != 'BUYER')
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceMuted,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Sign in with a Buyer account to send purchase requests for this residue lot.',
                          style: TextStyle(color: AppColors.textMuted, fontSize: 13),
                        ),
                      ),
                  ],
                ],
              ),
            ),
    );
  }
}
