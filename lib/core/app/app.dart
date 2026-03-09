import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/welcome_screen.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/presentation/providers/first_launch_provider.dart';
import '../../features/home/presentation/screens/main_layout.dart';
import '../theme/app_theme.dart';
import '../theme/theme_provider.dart';

/// Root widget for the Calcetto application.
///
/// Provides the ProviderScope for state management and configures
/// the Material 3 theme.
class CalcettoApp extends ConsumerWidget {
  const CalcettoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return ProviderScope(
      child: MaterialApp(
        title: 'Calcetto',
        debugShowCheckedModeBanner: false,
        themeMode: themeMode,
        theme: AppTheme.lightTheme(),
        darkTheme: AppTheme.darkTheme(),
        home: const AuthWrapper(),
      ),
    );
  }
}

/// Wrapper that handles app startup flow: first launch -> login -> home.
///
/// Flow:
/// 1. First launch: Show welcome screen
/// 2. Not authenticated: Show login screen
/// 3. Authenticated: Show main layout with bottom navigation
class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFirstLaunch = ref.watch(firstLaunchProvider);
    final authState = ref.watch(authStateProvider);

    // First launch: show welcome screen
    if (isFirstLaunch) {
      return const WelcomeScreen();
    }

    // Check authentication status
    return authState.maybeWhen(
      authenticated: (user) {
        // Navigate to main layout with bottom navigation
        return const MainLayout();
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      orElse: () => const LoginScreen(),
    );
  }
}
