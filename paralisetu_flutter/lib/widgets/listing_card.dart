import 'package:flutter/material.dart';
import 'package:paralisetu_client/paralisetu_client.dart';
import '../core/constants.dart';
import '../core/formatters.dart';
import 'glass_container.dart';
import 'status_badge.dart';

class ListingCard extends StatelessWidget {
  final ParaliListing listing;
  final MatchResult? match;
  final Widget? trailingAction;

  const ListingCard({
    super.key,
    required this.listing,
    this.match,
    this.trailingAction,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${listing.district} · ${listing.farmerName ?? "Farmer"}',
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              StatusBadge(status: listing.status),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            listing.crop,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            listing.description,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.surfaceMuted,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Available stock',
                        style: TextStyle(color: AppColors.textMuted, fontSize: 11),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        Formatters.kg(listing.availableKg),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(height: 30, width: 1, color: AppColors.border),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Price per kg',
                        style: TextStyle(color: AppColors.textMuted, fontSize: 11),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        Formatters.money(listing.pricePerKg),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: AppColors.brandGreen,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Harvested ${Formatters.date(listing.harvestDate)} · Window ${Formatters.date(listing.availableFrom)} to ${Formatters.date(listing.availableUntil)}',
            style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
          ),
          if (match != null) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.brandAmberLight,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.brandGolden.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Match score: ${match!.score} / 100',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.brandGolden,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  for (final reason in match!.reasons)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle_outline, size: 14, color: AppColors.brandGolden),
                          const SizedBox(width: 6),
                          Text(reason, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
          if (trailingAction != null) ...[
            const SizedBox(height: 12),
            trailingAction!,
          ],
        ],
      ),
    );
  }
}
