import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../../core/widgets/app_drawer.dart';
import '../../../auth/presentation/screens/login_screen.dart';
import '../../../profile/presentation/screens/edit_profile_screen.dart';
import '../../../clubs/presentation/screens/deleted_clubs_screen.dart';

/// Profile screen showing user info.
///
/// Displays user avatar, name, email.
/// Supports pull-to-refresh to reload user data.
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _refreshData() async {
    // Refresh auth session to reload user data
    await ref.read(authSessionProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final authSession = ref.watch(authSessionProvider);
    final colorScheme = Theme.of(context).colorScheme;

    // Check if user is authenticated
    final isAuthenticated = authSession.isAuthenticated;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
          ),
        ],
      ),
      endDrawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                MediaQuery.of(context).padding.top,
            child: isAuthenticated
                ? _buildAuthenticatedContent(
                    context, ref, authSession, colorScheme)
                : _buildLoggedOutContent(context, ref, colorScheme),
          ),
        ),
      ),
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
          // Edit profile button
          FilledButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const EditProfileScreen(),
                ),
              );
            },
            icon: const Icon(Icons.edit),
            label: const Text('Edit Profile'),
          ),
          const SizedBox(height: 16),
          // Deleted clubs button
          OutlinedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const DeletedClubsScreen(),
                ),
              );
            },
            icon: const Icon(Icons.restore_from_trash),
            label: const Text('Club Eliminati'),
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
