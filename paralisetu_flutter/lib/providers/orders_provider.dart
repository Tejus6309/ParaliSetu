import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paralisetu_client/paralisetu_client.dart';
import '../core/client.dart';
import 'auth_provider.dart';

final ordersListProvider = FutureProvider.autoDispose<List<ParaliOrder>>((ref) async {
  final client = ref.watch(clientProvider);
  final auth = ref.watch(authProvider);

  final user = auth.user;
  if (user == null || user.id == null) return [];

  return client.orders.getOrders(user.id!, user.role);
});

final carriersListProvider = FutureProvider.autoDispose<List<ParaliUser>>((ref) async {
  final client = ref.watch(clientProvider);
  return client.orders.getCarriers();
});
