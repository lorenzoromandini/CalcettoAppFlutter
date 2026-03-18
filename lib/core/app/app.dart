import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/providers/auth_providers.dart';
import '../../features/home/presentation/screens/main_layout.dart';
import '../../features/clubs/presentation/screens/join_club_screen.dart';
import '../theme/app_theme.dart';
import '../theme/theme_provider.dart';

/// Root widget with theme switching and routing support.
class CalcettoApp extends ConsumerStatefulWidget {
  const CalcettoApp({super.key});

  @override
  ConsumerState<CalcettoApp> createState() => _CalcettoAppState();
}

class _CalcettoAppState extends ConsumerState<CalcettoApp> {
  String? _inviteCode;

  @override
  void initState() {
    super.initState();
    // Check for invite code in URL (deep link)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkDeepLink();
    });
  }

  void _checkDeepLink() {
    // Parse current URL
    final uri = Uri.tryParse(Uri.base.toString());
    if (uri != null) {
      final code = uri.queryParameters['code'];
      if (code != null && code.isNotEmpty) {
        setState(() => _inviteCode = code);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final authState = ref.watch(authSessionProvider);

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

    // Check if user needs to join via invite code
    if (authState.isAuthenticated && _inviteCode != null) {
      final code = _inviteCode!;
      _inviteCode = null; // Clear after handling
      return MaterialApp(
        title: 'Calcetto',
        debugShowCheckedModeBanner: false,
        themeMode: themeMode,
        theme: AppTheme.lightTheme(),
        darkTheme: AppTheme.darkTheme(),
        home: JoinClubScreen(initialCode: code),
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
