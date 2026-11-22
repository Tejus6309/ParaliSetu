import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paralisetu_client/paralisetu_client.dart';
import '../../core/client.dart';
import '../../core/constants.dart';
import '../../core/formatters.dart';
import '../../providers/auth_provider.dart';
import '../../providers/orders_provider.dart';
import '../../widgets/error_banner.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/status_badge.dart';
import '../pickup/pickup_room_dialog.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> {
  String? _error;
  bool _isBusy = false;

  void _handleAction(ParaliOrder order, String action) async {
    final client = ref.read(clientProvider);
    final user = ref.read(authProvider).user;
    if (user == null || user.id == null) return;

    if (action == 'CANCEL') {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Cancel Order?'),
          content: const Text('Cancelling will return reserved stock to the marketplace.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Back')),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: AppColors.dangerRed),
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Cancel Order'),
            ),
          ],
        ),
      );
      if (confirm != true) return;
    }

    if (action == 'ASSIGN') {
      final carriers = await ref.read(carriersListProvider.future);
      if (!mounted) return;
      final selectedCarrier = await showDialog<ParaliUser>(
        context: context,
        builder: (ctx) => SimpleDialog(
          title: const Text('Choose Logistics Provider'),
          children: [
            for (final c in carriers)
              SimpleDialogOption(
                onPressed: () => Navigator.pop(ctx, c),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      const Icon(Icons.local_shipping_outlined, color: AppColors.brandGreen, size: 20),
                      const SizedBox(width: 10),
                      Text(c.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
          ],
        ),
      );
      if (selectedCarrier == null) return;

      _executeChange(order.id!, action, carrierId: selectedCarrier.id);
      return;
    }

    _executeChange(order.id!, action);
  }

  void _executeChange(int orderId, String action, {int? carrierId}) async {
    final client = ref.read(clientProvider);
    final user = ref.read(authProvider).user;
    if (user == null || user.id == null) return;

    setState(() { _isBusy = true; _error = null; });

    try {
      await client.orders.changeOrder(
        userId: user.id!,
        userRole: user.role,
        orderId: orderId,
        action: action,
        carrierId: carrierId,
      );
      ref.refresh(ordersListProvider);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  List<String> _getAvailableActions(String role, String status) {
    if (role == 'FARMER') {
      if (status == 'REQUESTED') return ['ACCEPT', 'REJECT'];
      if (status == 'ACCEPTED') return ['ASSIGN', 'CANCEL'];
      if (status == 'ASSIGNED') return ['CANCEL'];
    }
    if (role == 'BUYER' && ['REQUESTED', 'ACCEPTED', 'ASSIGNED'].contains(status)) {
      return ['CANCEL'];
    }
    if (role == 'LOGISTICS' && status == 'ASSIGNED') return ['PICK_UP'];
    if (role == 'LOGISTICS' && status == 'PICKED_UP') return ['DELIVER'];
    return [];
  }

  String _actionLabel(String action) {
    switch (action) {
      case 'ACCEPT': return 'Accept & Reserve';
      case 'REJECT': return 'Reject Request';
      case 'ASSIGN': return 'Assign Pickup';
      case 'PICK_UP': return 'Mark Picked Up';
      case 'DELIVER': return 'Mark Delivered';
      case 'CANCEL': return 'Cancel Order';
      default: return action;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ordersAsync = ref.watch(ordersListProvider);
    final user = ref.watch(authProvider).user;
    final role = user?.role ?? 'BUYER';

    final title = {
      'FARMER': 'Requests & Orders',
      'BUYER': 'My Orders',
      'LOGISTICS': 'Delivery Assignments',
      'ADMIN': 'All Orders',
    }[role] ?? 'Orders';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        onRefresh: () async => ref.refresh(ordersListProvider.future),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 4),
            const Text(
              'Follow purchase requests, transport coordination, and pickup rooms through delivery.',
              style: TextStyle(color: AppColors.textMuted, fontSize: 13),
            ),
            const SizedBox(height: 16),

            if (_error != null)
              ErrorBanner(message: _error, onDismiss: () => setState(() => _error = null)),

            ordersAsync.when(
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: CircularProgressIndicator(color: AppColors.brandGreen),
                ),
              ),
              error: (err, _) => ErrorBanner(message: err.toString()),
              data: (orders) {
                if (orders.isEmpty) {
                  return const GlassContainer(
                    padding: EdgeInsets.all(32),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(Icons.assignment_outlined, size: 48, color: AppColors.textMuted),
                          SizedBox(height: 12),
                          Text(
                            'No orders to display yet.',
                            style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textMuted),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return Column(
                  children: [
                    for (final order in orders) ...[
                      GlassContainer(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Order #${order.id} · ${order.district}',
                                  style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
                                ),
                                StatusBadge(status: order.status),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              order.crop,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${Formatters.kg(order.quantityKg)} at ${Formatters.money(order.pricePerKg)} / kg',
                              style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${order.farmerName ?? "Farmer"} → ${order.buyerName ?? "Buyer"}',
                              style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                            ),
                            if (order.carrierName != null) ...[
                              const SizedBox(height: 2),
                              Text(
                                'Transport by ${order.carrierName}',
                                style: const TextStyle(color: AppColors.brandGreen, fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                            ],
                            const SizedBox(height: 12),

                            // Action Buttons & Pickup Room Trigger
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (['FARMER', 'LOGISTICS'].contains(role) && order.carrierId != null) ...[
                                  OutlinedButton.icon(
                                    icon: const Icon(Icons.meeting_room_outlined, size: 16),
                                    label: const Text('Open Pickup Room'),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) => PickupRoomDialog(orderId: order.id!),
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                ],

                                for (final action in _getAvailableActions(role, order.status)) ...[
                                  FilledButton(
                                    style: FilledButton.styleFrom(
                                      backgroundColor: ['CANCEL', 'REJECT'].contains(action)
                                          ? AppColors.dangerRed
                                          : AppColors.brandGreen,
                                    ),
                                    onPressed: _isBusy ? null : () => _handleAction(order, action),
                                    child: Text(_actionLabel(action)),
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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
