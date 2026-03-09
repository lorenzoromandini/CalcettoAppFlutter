import 'package:flutter/material.dart';
import '../../../../core/widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<ScaffoldState>();
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      key: key,
      appBar: AppBar(title: const Text('Home'), actions: [IconButton(icon: const Icon(Icons.menu), onPressed: () => key.currentState!.openEndDrawer())]),
      endDrawer: const AppDrawer(),
      body: SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Card(color: cs.primaryContainer, child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Welcome to Calcetto!', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text('Manage your football club')])))],
      )),
    );
  }
}
