import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants.dart';
import '../../providers/auth_provider.dart';
import '../farmer_listings/farmer_listings_screen.dart';
import '../impact/impact_screen.dart';
import '../marketplace/marketplace_screen.dart';
import '../matching/matching_screen.dart';
import '../orders/orders_screen.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider).user;
    final role = user?.role ?? 'BUYER';

    final navItems = _buildNavItems(role);
    final screens = _buildScreens(role);

    if (_currentIndex >= screens.length) {
      _currentIndex = 0;
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 32,
              height: 32,
              errorBuilder: (_, __, ___) => const Icon(Icons.eco, color: AppColors.brandGreen, size: 28),
            ),
            const SizedBox(width: 8),
            RichText(
              text: const TextSpan(
                text: 'Parali',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                children: [
                  TextSpan(
                    text: 'Setu',
                    style: TextStyle(
                      color: AppColors.brandSeed,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Chip(
              backgroundColor: AppColors.surfaceMuted,
              label: Text(
                '${user?.name ?? "User"} (${role.toLowerCase()})',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
              ),
              avatar: CircleAvatar(
                backgroundColor: AppColors.brandSeed,
                child: Text(
                  user?.name.isNotEmpty == true ? user!.name[0].toUpperCase() : 'U',
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
          ),
        ],
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (idx) => setState(() => _currentIndex = idx),
        destinations: navItems,
      ),
    );
  }

  List<NavigationDestination> _buildNavItems(String role) {
    switch (role) {
      case 'FARMER':
        return const [
          NavigationDestination(icon: Icon(Icons.inventory_2_outlined), selectedIcon: Icon(Icons.inventory_2), label: 'My Listings'),
          NavigationDestination(icon: Icon(Icons.assignment_outlined), selectedIcon: Icon(Icons.assignment), label: 'Orders'),
          NavigationDestination(icon: Icon(Icons.analytics_outlined), selectedIcon: Icon(Icons.analytics), label: 'Impact'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ];
      case 'BUYER':
        return const [
          NavigationDestination(icon: Icon(Icons.storefront_outlined), selectedIcon: Icon(Icons.storefront), label: 'Market'),
          NavigationDestination(icon: Icon(Icons.auto_awesome_outlined), selectedIcon: Icon(Icons.auto_awesome), label: 'Matches'),
          NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: 'Orders'),
          NavigationDestination(icon: Icon(Icons.analytics_outlined), selectedIcon: Icon(Icons.analytics), label: 'Impact'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ];
      case 'LOGISTICS':
        return const [
          NavigationDestination(icon: Icon(Icons.local_shipping_outlined), selectedIcon: Icon(Icons.local_shipping), label: 'Deliveries'),
          NavigationDestination(icon: Icon(Icons.analytics_outlined), selectedIcon: Icon(Icons.analytics), label: 'Impact'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ];
      case 'ADMIN':
      default:
        return const [
          NavigationDestination(icon: Icon(Icons.storefront_outlined), selectedIcon: Icon(Icons.storefront), label: 'Market'),
          NavigationDestination(icon: Icon(Icons.assignment_outlined), selectedIcon: Icon(Icons.assignment), label: 'All Orders'),
          NavigationDestination(icon: Icon(Icons.analytics_outlined), selectedIcon: Icon(Icons.analytics), label: 'Impact'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ];
    }
  }

  List<Widget> _buildScreens(String role) {
    switch (role) {
      case 'FARMER':
        return const [
          FarmerListingsScreen(),
          OrdersScreen(),
          ImpactScreen(),
          ProfileScreen(),
        ];
      case 'BUYER':
        return const [
          MarketplaceScreen(),
          MatchingScreen(),
          OrdersScreen(),
          ImpactScreen(),
          ProfileScreen(),
        ];
      case 'LOGISTICS':
        return const [
          OrdersScreen(),
          ImpactScreen(),
          ProfileScreen(),
        ];
      case 'ADMIN':
      default:
        return const [
          MarketplaceScreen(),
          OrdersScreen(),
          ImpactScreen(),
          ProfileScreen(),
        ];
    }
  }
}
