import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants.dart';
import '../../core/formatters.dart';
import '../../providers/auth_provider.dart';
import '../../providers/pickup_room_provider.dart';
import '../../widgets/error_banner.dart';
import '../../widgets/status_badge.dart';

class PickupRoomDialog extends ConsumerWidget {
  final int orderId;

  const PickupRoomDialog({super.key, required this.orderId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pickupRoomFamily(orderId));
    final notifier = ref.read(pickupRoomFamily(orderId).notifier);
    final role = ref.watch(authProvider).user?.role ?? '';
    final room = state.room;

    final hasUserArrived = role == 'FARMER'
        ? room?.farmerArrivedAt != null
        : room?.carrierArrivedAt != null;

    final bothArrived = room != null &&
        room.farmerArrivedAt != null &&
        room.carrierArrivedAt != null;

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Pickup Room #$orderId'),
          if (room != null) StatusBadge(status: room.status),
        ],
      ),
      content: SizedBox(
        width: 440,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (state.error != null) ErrorBanner(message: state.error),

            if (room == null && state.error == null) ...[
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator(color: AppColors.brandGreen),
                ),
              ),
            ] else if (room != null) ...[
              Text(
                '${room.district} · ${room.crop} · ${Formatters.kg(room.quantityKg)}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 16),

              // Farmer Arrival Card
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: room.farmerArrivedAt != null ? AppColors.activeGreenBg : AppColors.surfaceMuted,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      room.farmerArrivedAt != null ? Icons.check_circle : Icons.schedule,
                      color: room.farmerArrivedAt != null ? AppColors.activeGreen : AppColors.textMuted,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(room.farmerName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                          Text(
                            room.farmerArrivedAt != null
                                ? 'At pickup site (${Formatters.date(room.farmerArrivedAt)})'
                                : 'Awaiting farmer arrival',
                            style: TextStyle(
                              color: room.farmerArrivedAt != null ? AppColors.activeGreen : AppColors.textMuted,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Transporter Arrival Card
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: room.carrierArrivedAt != null ? AppColors.activeGreenBg : AppColors.surfaceMuted,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      room.carrierArrivedAt != null ? Icons.check_circle : Icons.schedule,
                      color: room.carrierArrivedAt != null ? AppColors.activeGreen : AppColors.textMuted,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(room.carrierName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                          Text(
                            room.carrierArrivedAt != null
                                ? 'At pickup site (${Formatters.date(room.carrierArrivedAt)})'
                                : 'Awaiting transport vehicle',
                            style: TextStyle(
                              color: room.carrierArrivedAt != null ? AppColors.activeGreen : AppColors.textMuted,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Overall Room Status Message
              Center(
                child: Text(
                  room.status != 'ASSIGNED'
                      ? 'Room closed · ${room.status}'
                      : bothArrived
                          ? 'Both participants are at pickup!'
                          : 'Waiting for mutual check-in. Auto-refreshing every 2s.',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: bothArrived ? AppColors.activeGreen : AppColors.textMuted,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Arrive Button
              if (room.status == 'ASSIGNED' && !hasUserArrived)
                FilledButton.icon(
                  onPressed: state.isBusy ? null : () => notifier.arrive(),
                  icon: const Icon(Icons.location_on, size: 18),
                  label: state.isBusy
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Text('I am at the pickup site'),
                ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close Room'),
        ),
      ],
    );
  }
}
