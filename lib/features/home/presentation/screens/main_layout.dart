import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/bottom_nav_bar.dart';
import '../providers/navigation_provider.dart';
import 'home_screen.dart';
import 'clubs_screen.dart';
import 'matches_screen.dart';
import 'profile_screen.dart';

/// Main layout with bottom navigation and screen switching.
///
/// Uses IndexedStack to preserve state when switching between tabs.
class MainLayout extends ConsumerWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationState = ref.watch(navigationProvider);

    // List of screens corresponding to navigation indices
    final screens = const [
      HomeScreen(),
      ClubsScreen(),
      MatchesScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: navigationState.currentIndex,
        children: screens,
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
