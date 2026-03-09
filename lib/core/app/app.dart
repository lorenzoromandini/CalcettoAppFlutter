import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/welcome_screen.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/presentation/providers/first_launch_provider.dart';
import '../../features/home/presentation/screens/main_layout.dart';
import '../theme/app_theme.dart';
import '../theme/theme_provider.dart';

/// Root widget with theme switching support.
class CalcettoApp extends ConsumerWidget {
  const CalcettoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      title: 'Calcetto',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      home: const LoginScreen(),
    );
  }
}
