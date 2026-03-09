import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../../../../core/widgets/app_drawer.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});
  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _idx = 0;
  final _key = GlobalKey<ScaffoldState>();
  final _screens = [const HomeScreen(), _Placeholder('Clubs', Icons.people), _Placeholder('Matches', Icons.sports_soccer), _Placeholder('Profile', Icons.person)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(title: const Text('Calcetto'), actions: [IconButton(icon: const Icon(Icons.menu), onPressed: () => _key.currentState!.openEndDrawer())]),
      endDrawer: const AppDrawer(),
      body: _screens[_idx],
      bottomNavigationBar: NavigationBar(selectedIndex: _idx, onDestinationSelected: (i) => setState(() => _idx = i),
        destinations: const [NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'), NavigationDestination(icon: Icon(Icons.people_outlined), label: 'Clubs'), NavigationDestination(icon: Icon(Icons.sports_soccer), label: 'Matches'), NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile')]),
    );
  }
}

class _Placeholder extends StatelessWidget {
  final String t; final IconData i;
  const _Placeholder(this.t, this.i);
  @override
  Widget build(BuildContext c) => Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(i, size: 80), const SizedBox(height: 16), Text(t, style: Theme.of(c).textTheme.headlineSmall)]));
}
