import 'package:flutter/material.dart';
import '../core/constants.dart';

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    String label = status;

    switch (status.toUpperCase()) {
      case 'ACTIVE':
        bg = AppColors.activeGreenBg;
        fg = AppColors.activeGreen;
        label = 'Active';
        break;
      case 'REQUESTED':
        bg = AppColors.warningOrangeBg;
        fg = AppColors.warningOrange;
        label = 'Requested';
        break;
      case 'ACCEPTED':
        bg = AppColors.infoBlueBg;
        fg = AppColors.infoBlue;
        label = 'Accepted';
        break;
      case 'ASSIGNED':
        bg = const Color(0xFFF3E8FF);
        fg = const Color(0xFF7E22CE);
        label = 'Assigned';
        break;
      case 'PICKED_UP':
        bg = const Color(0xFFE0E7FF);
        fg = const Color(0xFF4338CA);
        label = 'Picked Up';
        break;
      case 'DELIVERED':
        bg = AppColors.activeGreenBg;
        fg = AppColors.activeGreen;
        label = 'Delivered';
        break;
      case 'PAUSED':
        bg = AppColors.surfaceMuted;
        fg = AppColors.textMuted;
        label = 'Paused';
        break;
      case 'REMOVED':
      case 'DELETED':
      case 'CANCELLED':
      case 'REJECTED':
        bg = AppColors.dangerRedBg;
        fg = AppColors.dangerRed;
        label = status.substring(0, 1) + status.substring(1).toLowerCase();
        break;
      default:
        bg = AppColors.surfaceMuted;
        fg = AppColors.textPrimary;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: fg,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
