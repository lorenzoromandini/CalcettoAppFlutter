import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
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

/// Wrapper that checks authentication status on app start.
class AuthWrapper extends ConsumerStatefulWidget {
  const AuthWrapper({super.key});

  @override
  ConsumerState<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends ConsumerState<AuthWrapper> {
  @override
  void initState() {
    super.initState();
    // Check auth status on app start
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authStateProvider.notifier).checkAuthStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    return authState.maybeWhen(
      authenticated: (user) {
        // TODO: Navigate to home screen when authenticated
        return const LoginScreen(); // Temporary - will be replaced with home in next plan
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
