import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../../core/widgets/app_drawer.dart';
import '../../../auth/presentation/screens/login_screen.dart';

/// Profile screen showing user info.
///
/// Displays user avatar, name, email.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authSession = ref.watch(authSessionProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final scaffoldKey = GlobalKey<ScaffoldState>();

    // Check if user is authenticated
    final isAuthenticated = authSession.isAuthenticated;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
          ),
        ],
      ),
      endDrawer: const AppDrawer(),
      body: isAuthenticated
          ? _buildAuthenticatedContent(context, ref, authSession, colorScheme)
          : _buildLoggedOutContent(context, ref, colorScheme),
    );
  }

  Widget _buildAuthenticatedContent(BuildContext context, WidgetRef ref,
      AuthSessionState authSession, ColorScheme colorScheme) {
    final user = authSession.user;

    if (user == null) {
      return _buildLoggedOutContent(context, ref, colorScheme);
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // User avatar
          CircleAvatar(
            radius: 60,
            backgroundColor: colorScheme.primaryContainer,
            child: Icon(
              Icons.person,
              size: 60,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 24),
          // User name
          Text(
            user.name.isNotEmpty ? user.name : user.email,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          // User email
          Text(
            user.email,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 48),
          // Edit profile button (placeholder)
          FilledButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edit profile - Coming soon')),
              );
            },
            icon: const Icon(Icons.edit),
            label: const Text('Edit Profile'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoggedOutContent(
      BuildContext context, WidgetRef ref, ColorScheme colorScheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_circle_outlined,
            size: 100,
            color: colorScheme.onSurface.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 24),
          Text(
            'Not Logged In',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Text(
            'Please log in to view your profile',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 32),
          FilledButton.icon(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
            icon: const Icon(Icons.login),
            label: const Text('Log In'),
          ),
        ],
      ),
    );
  }
}
