import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paralisetu_client/paralisetu_client.dart';
import '../core/client.dart';
import 'auth_provider.dart';

class PickupRoomState {
  final PickupRoomView? room;
  final bool isBusy;
  final String? error;

  const PickupRoomState({this.room, this.isBusy = false, this.error});

  PickupRoomState copyWith({PickupRoomView? room, bool? isBusy, String? error, bool clearError = false}) {
    return PickupRoomState(
      room: room ?? this.room,
      isBusy: isBusy ?? this.isBusy,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

class PickupRoomNotifier extends StateNotifier<PickupRoomState> {
  final Client _client;
  final int _orderId;
  final int _userId;
  final String _userRole;
  Timer? _timer;

  PickupRoomNotifier({
    required Client client,
    required int orderId,
    required int userId,
    required String userRole,
  })  : _client = client,
        _orderId = orderId,
        _userId = userId,
        _userRole = userRole,
        super(const PickupRoomState()) {
    _startPolling();
  }

  void _startPolling() {
    refresh();
    _timer = Timer.periodic(const Duration(seconds: 2), (_) => refresh());
  }

  Future<void> refresh() async {
    try {
      final updated = await _client.pickupRoom.getPickupRoom(_userId, _userRole, _orderId);
      state = state.copyWith(room: updated, clearError: true);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> arrive() async {
    if (state.isBusy) return;
    state = state.copyWith(isBusy: true, clearError: true);
    try {
      final updated = await _client.pickupRoom.arrive(_userId, _userRole, _orderId);
      state = state.copyWith(room: updated, isBusy: false);
    } catch (e) {
      state = state.copyWith(isBusy: false, error: e.toString());
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final pickupRoomFamily = StateNotifierProvider.autoDispose
    .family<PickupRoomNotifier, PickupRoomState, int>((ref, orderId) {
  final client = ref.watch(clientProvider);
  final auth = ref.watch(authProvider);

  return PickupRoomNotifier(
    client: client,
    orderId: orderId,
    userId: auth.user?.id ?? 0,
    userRole: auth.user?.role ?? '',
  );
});
