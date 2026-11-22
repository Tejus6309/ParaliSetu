import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/status_badge.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).user;
    final initial = user?.name.isNotEmpty == true ? user!.name.substring(0, 1).toUpperCase() : 'U';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'My Profile',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 16),

          GlassContainer(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: AppColors.brandSeed,
                  child: Text(
                    initial,
                    style: const TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  user?.name ?? 'User',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                ),
                const SizedBox(height: 6),
                if (user != null) StatusBadge(status: user.role),
                const SizedBox(height: 24),

                _ProfileRow(label: 'Full Name', value: user?.name ?? ''),
                const Divider(height: 20, color: AppColors.border),
                _ProfileRow(label: 'Email Address', value: user?.email ?? ''),
                const Divider(height: 20, color: AppColors.border),
                _ProfileRow(label: 'Account Role', value: user?.role ?? ''),
                const SizedBox(height: 32),

                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.dangerRed,
                    minimumSize: const Size.fromHeight(48),
                  ),
                  onPressed: () => ref.read(authProvider.notifier).logout(),
                  icon: const Icon(Icons.logout, size: 18),
                  label: const Text('Sign out of ParaliSetu'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileRow extends StatelessWidget {
  final String label;
  final String value;

  const _ProfileRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.textPrimary)),
      ],
    );
  }
}
