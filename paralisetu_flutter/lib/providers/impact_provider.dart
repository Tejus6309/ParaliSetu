import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paralisetu_client/paralisetu_client.dart';
import '../core/client.dart';

final impactStatsProvider = FutureProvider.autoDispose<ImpactStats>((ref) async {
  final client = ref.watch(clientProvider);
  return client.insights.impact();
});
