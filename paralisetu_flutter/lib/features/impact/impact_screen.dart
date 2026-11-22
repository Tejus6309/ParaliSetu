import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants.dart';
import '../../core/formatters.dart';
import '../../providers/impact_provider.dart';
import '../../widgets/error_banner.dart';
import '../../widgets/glass_container.dart';

class ImpactScreen extends ConsumerWidget {
  const ImpactScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(impactStatsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        onRefresh: () async => ref.refresh(impactStatsProvider.future),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Marketplace Impact',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 4),
            const Text(
              'Platform-wide totals verified from deliveries marked complete by transport providers.',
              style: TextStyle(color: AppColors.textMuted, fontSize: 13),
            ),
            const SizedBox(height: 16),

            statsAsync.when(
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: CircularProgressIndicator(color: AppColors.brandGreen),
                ),
              ),
              error: (err, _) => ErrorBanner(message: err.toString()),
              data: (stats) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Metric Cards Row
                    Row(
                      children: [
                        Expanded(
                          child: GlassContainer(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Residue Delivered', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                                const SizedBox(height: 6),
                                Text(
                                  Formatters.kg(stats.deliveredKg),
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.brandGreen),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: GlassContainer(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Deliveries Done', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                                const SizedBox(height: 6),
                                Text(
                                  '${stats.deliveries}',
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    GlassContainer(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Estimated Burning Diversion', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                          const SizedBox(height: 6),
                          Text(
                            Formatters.kg(stats.estimatedDivertedKg),
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.brandGolden),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Caveat Note
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceMuted,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(
                        stats.caveat,
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, fontStyle: FontStyle.italic),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Delivered by Crop Breakdown
                    GlassContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Delivered Residue by Crop',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                          ),
                          const SizedBox(height: 12),
                          if (stats.byCrop.isEmpty)
                            const Text('No deliveries completed yet.', style: TextStyle(color: AppColors.textMuted))
                          else
                            for (final crop in stats.byCrop) ...[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(crop.crop, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                                        Text(Formatters.kg(crop.deliveredKg), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: LinearProgressIndicator(
                                        value: stats.deliveredKg > 0 ? crop.deliveredKg / stats.deliveredKg : 0,
                                        backgroundColor: AppColors.surfaceMuted,
                                        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.brandGreen),
                                        minHeight: 8,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
