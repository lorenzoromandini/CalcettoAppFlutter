import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/providers/auth_providers.dart';
import '../../features/home/presentation/screens/main_layout.dart';
import '../theme/app_theme.dart';
import '../theme/theme_provider.dart';

/// Root widget with theme switching support.
class CalcettoApp extends ConsumerWidget {
  const CalcettoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final authState = ref.watch(authSessionProvider);

    debugPrint(
        'APP: authState = isLoading:${authState.isLoading} isAuthenticated:${authState.isAuthenticated} user:${authState.user?.email}');

    if (authState.isLoading) {
      return MaterialApp(
        title: 'Calcetto',
        debugShowCheckedModeBanner: false,
        themeMode: themeMode,
        theme: AppTheme.lightTheme(),
        darkTheme: AppTheme.darkTheme(),
        home: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return MaterialApp(
      title: 'Calcetto',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      home:
          authState.isAuthenticated ? const MainLayout() : const LoginScreen(),
    );
  }
}
