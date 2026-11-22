import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paralisetu_client/paralisetu_client.dart';
import '../../core/client.dart';
import '../../core/constants.dart';
import '../../core/formatters.dart';
import '../../providers/auth_provider.dart';
import '../../providers/listings_provider.dart';
import '../../widgets/error_banner.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/listing_card.dart';

class FarmerListingsScreen extends ConsumerStatefulWidget {
  const FarmerListingsScreen({super.key});

  @override
  ConsumerState<FarmerListingsScreen> createState() => _FarmerListingsScreenState();
}

class _FarmerListingsScreenState extends ConsumerState<FarmerListingsScreen> {
  String? _error;

  void _showListingEditor({ParaliListing? existing}) {
    showDialog(
      context: context,
      builder: (_) => _ListingEditorDialog(
        existing: existing,
        onSaved: () {
          ref.refresh(farmerListingsProvider);
          ref.refresh(browseListingsProvider);
        },
      ),
    );
  }

  void _toggleStatus(ParaliListing listing) async {
    final client = ref.read(clientProvider);
    final user = ref.read(authProvider).user;
    if (user == null || user.id == null) return;

    final newStatus = listing.status == 'ACTIVE' ? 'PAUSED' : 'ACTIVE';
    try {
      await client.listings.status(user.id!, listing.id!, newStatus);
      ref.refresh(farmerListingsProvider);
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  void _deleteListing(ParaliListing listing) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Listing?'),
        content: const Text('Existing orders will retain their transaction history.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.dangerRed),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    final client = ref.read(clientProvider);
    final user = ref.read(authProvider).user;
    if (user == null || user.id == null) return;

    try {
      await client.listings.delete(user.id!, listing.id!);
      ref.refresh(farmerListingsProvider);
      ref.refresh(browseListingsProvider);
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final listingsAsync = ref.watch(farmerListingsProvider);
    final user = ref.watch(authProvider).user;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        onRefresh: () async => ref.refresh(farmerListingsProvider.future),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'My Residue Listings',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Manage available biomass stock for ${user?.name ?? "Farmer"}',
                      style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
                    ),
                  ],
                ),
                FilledButton.icon(
                  onPressed: () => _showListingEditor(),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('New Listing'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            if (_error != null)
              ErrorBanner(
                message: _error,
                onDismiss: () => setState(() => _error = null),
              ),

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
                  return GlassContainer(
                    padding: const EdgeInsets.all(32),
                    child: Center(
                      child: Column(
                        children: [
                          const Icon(Icons.post_add, size: 48, color: AppColors.textMuted),
                          const SizedBox(height: 12),
                          const Text(
                            'You have not published any residue listings yet.',
                            style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textMuted),
                          ),
                          const SizedBox(height: 16),
                          FilledButton(
                            onPressed: () => _showListingEditor(),
                            child: const Text('Create your first listing'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return Column(
                  children: [
                    for (final listing in listings)
                      ListingCard(
                        listing: listing,
                        trailingAction: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              onPressed: () => _showListingEditor(existing: listing),
                              child: const Text('Edit'),
                            ),
                            const SizedBox(width: 8),
                            OutlinedButton(
                              onPressed: () => _toggleStatus(listing),
                              child: Text(listing.status == 'ACTIVE' ? 'Pause' : 'Resume'),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.delete_outline, color: AppColors.dangerRed),
                              onPressed: () => _deleteListing(listing),
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

class _ListingEditorDialog extends ConsumerStatefulWidget {
  final ParaliListing? existing;
  final VoidCallback onSaved;

  const _ListingEditorDialog({this.existing, required this.onSaved});

  @override
  ConsumerState<_ListingEditorDialog> createState() => _ListingEditorDialogState();
}

class _ListingEditorDialogState extends ConsumerState<_ListingEditorDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _cropController;
  late final TextEditingController _districtController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _availableKgController;
  late final TextEditingController _priceController;

  late DateTime _harvestDate;
  late DateTime _availableFrom;
  late DateTime _availableUntil;
  bool _isSaving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final item = widget.existing;

    _cropController = TextEditingController(text: item?.crop ?? 'Rice straw');
    _districtController = TextEditingController(text: item?.district ?? 'Ludhiana');
    _descriptionController = TextEditingController(text: item?.description ?? '');
    _availableKgController = TextEditingController(text: item != null ? item.availableKg.toString() : '2000');
    _priceController = TextEditingController(text: item != null ? item.pricePerKg.toString() : '2.50');

    _harvestDate = item?.harvestDate ?? now.subtract(const Duration(days: 7));
    _availableFrom = item?.availableFrom ?? now;
    _availableUntil = item?.availableUntil ?? now.add(const Duration(days: 90));
  }

  @override
  void dispose() {
    _cropController.dispose();
    _districtController.dispose();
    _descriptionController.dispose();
    _availableKgController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(String type) async {
    DateTime initial = type == 'harvest' ? _harvestDate : type == 'from' ? _availableFrom : _availableUntil;
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (picked != null) {
      setState(() {
        if (type == 'harvest') _harvestDate = picked;
        if (type == 'from') _availableFrom = picked;
        if (type == 'until') _availableUntil = picked;
      });
    }
  }

  void _save() async {
    if (!_formKey.currentState!.validate()) return;

    if (_harvestDate.isAfter(_availableFrom) || _availableFrom.isAfter(_availableUntil)) {
      setState(() => _error = 'Ensure dates follow: Harvest Date ≤ Available From ≤ Available Until.');
      return;
    }

    final client = ref.read(clientProvider);
    final user = ref.read(authProvider).user;
    if (user == null || user.id == null) return;

    setState(() { _isSaving = true; _error = null; });

    try {
      final crop = _cropController.text.trim();
      final district = _districtController.text.trim();
      final desc = _descriptionController.text.trim();
      final kg = int.parse(_availableKgController.text.trim());
      final price = double.parse(_priceController.text.trim());

      if (widget.existing != null) {
        await client.listings.edit(
          farmerId: user.id!,
          id: widget.existing!.id!,
          version: widget.existing!.version,
          crop: crop,
          district: district,
          description: desc,
          availableKg: kg,
          pricePerKg: price,
          harvestDate: _harvestDate,
          availableFrom: _availableFrom,
          availableUntil: _availableUntil,
        );
      } else {
        await client.listings.create(
          farmerId: user.id!,
          farmerName: user.name,
          crop: crop,
          district: district,
          description: desc,
          availableKg: kg,
          pricePerKg: price,
          harvestDate: _harvestDate,
          availableFrom: _availableFrom,
          availableUntil: _availableUntil,
        );
      }

      widget.onSaved();
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) setState(() { _isSaving = false; _error = e.toString(); });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;

    return AlertDialog(
      title: Text(isEdit ? 'Edit Residue Listing' : 'Create Residue Listing'),
      content: SizedBox(
        width: 480,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_error != null) ErrorBanner(message: _error),
                TextFormField(
                  controller: _cropController,
                  decoration: const InputDecoration(labelText: 'Crop type'),
                  validator: (v) => v == null || v.trim().isEmpty ? 'Crop is required' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _districtController,
                  decoration: const InputDecoration(labelText: 'District'),
                  validator: (v) => v == null || v.trim().isEmpty ? 'District is required' : null,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _availableKgController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'Available stock (kg)'),
                        validator: (v) => int.tryParse(v ?? '') == null ? 'Enter valid kg' : null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _priceController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(labelText: 'Price per kg (₹)'),
                        validator: (v) => double.tryParse(v ?? '') == null ? 'Enter price' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 2,
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (v) => v == null || v.trim().isEmpty ? 'Description is required' : null,
                ),
                const SizedBox(height: 14),
                const Text('Availability Dates:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _pickDate('harvest'),
                        child: Text('Harvest: ${Formatters.date(_harvestDate)}', style: const TextStyle(fontSize: 11)),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _pickDate('from'),
                        child: Text('From: ${Formatters.date(_availableFrom)}', style: const TextStyle(fontSize: 11)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                OutlinedButton(
                  onPressed: () => _pickDate('until'),
                  child: Text('Until: ${Formatters.date(_availableUntil)}', style: const TextStyle(fontSize: 11)),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(
          onPressed: _isSaving ? null : _save,
          child: _isSaving
              ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
              : const Text('Save Listing'),
        ),
      ],
    );
  }
}
