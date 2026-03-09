import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/theme_provider.dart';

class AppDrawer extends ConsumerStatefulWidget {
  const AppDrawer({super.key});

  @override
  ConsumerState<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends ConsumerState<AppDrawer> {
  String _lang = 'it';

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final theme = ref.watch(themeModeProvider);
    
    return Drawer(
      child: SafeArea(
        child: Column(children: [
          Container(padding: const EdgeInsets.all(20), color: cs.primaryContainer,
            child: Row(children: [Icon(Icons.menu, color: cs.onPrimaryContainer), const SizedBox(width: 12), Text('Settings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: cs.onPrimaryContainer))]),
          ),
          Expanded(child: ListView(padding: EdgeInsets.zero, children: [
            ListTile(leading: Icon(theme == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode), title: const Text('Theme'), subtitle: Text(theme == ThemeMode.dark ? 'Dark' : theme == ThemeMode.light ? 'Light' : 'System'),
              onTap: () {
                final n = ref.read(themeModeProvider.notifier);
                theme == ThemeMode.dark ? n.setLight() : n.setDark();
              }),
            const Divider(),
            ListTile(leading: const Icon(Icons.language), title: const Text('Language'), subtitle: Text(_lang == 'it' ? 'Italiano' : 'English'),
              onTap: () {
                showDialog(context: context, builder: (c) => AlertDialog(title: const Text('Language'), content: const Text('Language switching coming soon'), actions: [TextButton(onPressed: () => Navigator.pop(c), child: const Text('OK'))]));
              }),
            const Divider(),
            ListTile(leading: const Icon(Icons.info), title: const Text('Version'), subtitle: const Text('1.0.0')),
          ])),
          Padding(padding: const EdgeInsets.all(16), child: Text('Calcetto Manager', style: TextStyle(fontSize: 12, color: cs.onSurface.withOpacity(0.5)))),
        ]),
      ),
    );
  }
}
