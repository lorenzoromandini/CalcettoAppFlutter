import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/theme_provider.dart';
import '../providers/offline_status_provider.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/presentation/screens/login_screen.dart';

class AppDrawer extends ConsumerStatefulWidget {
  const AppDrawer({super.key});

  @override
  ConsumerState<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends ConsumerState<AppDrawer> {
  final _lang = 'it';

  // Store theme locally to avoid rebuilds when theme changes
  late ThemeMode _currentTheme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize theme from provider once
    _currentTheme = ref.read(themeModeProvider);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    // Don't watch themeModeProvider - use read instead to prevent rebuilds
    final theme = _currentTheme;

    return Drawer(
      child: SafeArea(
        child: Column(children: [
          // Drawer header with offline indicator
          Container(
            padding: const EdgeInsets.all(20),
            color: cs.primaryContainer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(Icons.menu, color: cs.onPrimaryContainer),
                  const SizedBox(width: 12),
                  Text('Settings',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: cs.onPrimaryContainer))
                ]),
                const SizedBox(height: 8),
                Consumer(
                  builder: (context, ref, _) {
                    final isOffline = ref.watch(isOfflineProvider);
                    if (isOffline) {
                      return Row(
                        children: [
                          Icon(
                            Icons.cloud_off,
                            size: 14,
                            color: cs.onSecondaryContainer,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Offline mode',
                            style: TextStyle(
                              fontSize: 12,
                              color: cs.onSecondaryContainer,
                            ),
                          ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView(padding: EdgeInsets.zero, children: [
            ListTile(
                leading: Icon(_currentTheme == ThemeMode.dark
                    ? Icons.dark_mode
                    : Icons.light_mode),
                title: const Text('Theme'),
                subtitle: Text(_currentTheme == ThemeMode.dark
                    ? 'Dark'
                    : _currentTheme == ThemeMode.light
                        ? 'Light'
                        : 'System'),
                onTap: () {
                  final n = ref.read(themeModeProvider.notifier);
                  if (_currentTheme == ThemeMode.dark) {
                    n.setLight();
                    _currentTheme = ThemeMode.light;
                  } else {
                    n.setDark();
                    _currentTheme = ThemeMode.dark;
                  }
                  // Use postFrameCallback to update after rebuild cycle
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) setState(() {});
                  });
                }),
            const Divider(),
            ListTile(
                leading: const Icon(Icons.language),
                title: const Text('Language'),
                subtitle: Text(_lang == 'it' ? 'Italiano' : 'English'),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (c) =>
                          AlertDialog(
                              title: const Text('Language'),
                              content:
                                  const Text('Language switching coming soon'),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.pop(c),
                                    child: const Text('OK'))
                              ]));
                }),
            const Divider(),
            ListTile(
                leading: const Icon(Icons.info),
                title: const Text('Version'),
                subtitle: const Text('1.0.0')),
          ])),
          Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    textColor: cs.error,
                    iconColor: cs.error,
                    onTap: () async {
                      await ref.read(authStateProvider.notifier).logout();
                      if (context.mounted) {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (_) => const LoginScreen()),
                          (route) => false,
                        );
                      }
                    },
                  ),
                  Text('Calcetto Manager',
                      style: TextStyle(
                          fontSize: 12,
                          color: cs.onSurface.withValues(alpha: 0.5))),
                ],
              )),
        ]),
      ),
    );
  }
}
