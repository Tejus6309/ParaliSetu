import 'package:flutter/material.dart';
import '../core/constants.dart';

class ErrorBanner extends StatelessWidget {
  final String? message;
  final VoidCallback? onDismiss;

  const ErrorBanner({super.key, this.message, this.onDismiss});

  @override
  Widget build(BuildContext context) {
    if (message == null || message!.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.dangerRedBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.dangerRed.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: AppColors.dangerRed, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message!,
              style: const TextStyle(color: AppColors.dangerRed, fontSize: 13),
            ),
          ),
          if (onDismiss != null)
            IconButton(
              icon: const Icon(Icons.close, size: 16, color: AppColors.dangerRed),
              onPressed: onDismiss,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
        ],
      ),
    );
  }
}
