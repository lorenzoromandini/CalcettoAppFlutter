import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_screen.dart';
import '../../../clubs/presentation/screens/clubs_list_screen.dart';
import '../../../clubs/presentation/screens/club_detail_screen.dart';
import '../../../clubs/presentation/providers/active_club_provider.dart';
import '../../../home/presentation/screens/profile_screen.dart';
import '../../../../core/widgets/app_drawer.dart';

class MainLayout extends ConsumerStatefulWidget {
  const MainLayout({super.key});
  @override
  ConsumerState<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends ConsumerState<MainLayout> {
  int _idx = 0;
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final activeClubAsync = ref.watch(activeClubProvider);

    return Scaffold(
      key: _key,
      endDrawer: const AppDrawer(),
      body: IndexedStack(
        index: _idx,
        children: [
          const HomeScreen(),
          // Clubs tab shows detail of active club, or list if no active club
          activeClubAsync.when(
            loading: () => const _LoadingPlaceholder('Caricamento club...'),
            error: (_, __) => const ClubsListScreen(),
            data: (club) => club != null
                ? ClubDetailScreen(club: club)
                : const ClubsListScreen(),
          ),
          _Placeholder('Matches', Icons.sports_soccer),
          const ProfileScreen()
        ],
      ),
      bottomNavigationBar: NavigationBar(
          selectedIndex: _idx,
          onDestinationSelected: (i) => setState(() => _idx = i),
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home_outlined), label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.people_outlined), label: 'Clubs'),
            NavigationDestination(
                icon: Icon(Icons.sports_soccer), label: 'Matches'),
            NavigationDestination(
                icon: Icon(Icons.person_outline), label: 'Profile')
          ]),
    );
  }
}

class _Placeholder extends StatelessWidget {
  final String t;
  final IconData i;
  const _Placeholder(this.t, this.i);
  @override
  Widget build(BuildContext c) => Scaffold(
        appBar: AppBar(title: Text(t)),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(i, size: 80),
          const SizedBox(height: 16),
          Text(t, style: Theme.of(c).textTheme.headlineSmall)
        ])),
      );
}

class _LoadingPlaceholder extends StatelessWidget {
  final String message;
  const _LoadingPlaceholder(this.message);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Club')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(message),
          ],
        ),
      ),
    );
  }
}
