import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/providers/connectivity_provider.dart';
import '../../domain/entities/club.dart';
import '../providers/clubs_list_provider.dart';
import '../providers/active_club_provider.dart';
import '../widgets/clubs_list_skeleton.dart';
import '../widgets/club_list_item.dart';

/// Clubs list screen displaying user's club memberships.
///
/// Features:
/// - Pull-to-refresh for updating clubs list
/// - Shimmer loading skeleton during initial load
/// - Active club indicator (star icon)
/// - Long-press to switch active club
/// - Create button in app bar (future functionality)
/// - Offline indicator banner
class ClubsListScreen extends ConsumerStatefulWidget {
  const ClubsListScreen({super.key});

  @override
  ConsumerState<ClubsListScreen> createState() => _ClubsListScreenState();
}

class _ClubsListScreenState extends ConsumerState<ClubsListScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize clubs list
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(clubsListProvider.notifier).fetchClubs();
    });
  }

  @override
  Widget build(BuildContext context) {
    final clubsAsync = ref.watch(clubsListProvider);
    final activeClubAsync = ref.watch(activeClubProvider);
    final isOnlineAsync = ref.watch(isOnlineProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Clubs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _onCreateClub,
            tooltip: 'Create club',
          ),
        ],
      ),
      body: Column(
        children: [
          // Offline indicator banner
          if (isOnlineAsync.value == false)
            MaterialBanner(
              content: const Text('You are offline. Showing cached data.'),
              actions: const [],
              backgroundColor:
                  Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
          // Main content
          Expanded(
            child: clubsAsync.when(
              loading: () => const ClubsListSkeleton(),
              error: (error, stack) => _buildErrorState(error.toString()),
              data: (clubs) => _buildClubsList(
                  clubs, activeClubAsync.value, activeClubAsync.isLoading),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClubsList(
      List<Club> clubs, Club? activeClub, bool isLoadingActive) {
    if (clubs.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(clubsListProvider.notifier).refresh();
      },
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: clubs.length,
        cacheExtent: 200,
        itemBuilder: (context, index) {
          final club = clubs[index];
          final isActive = activeClub?.id == club.id;

          return RepaintBoundary(
            child: ClubListItem(
              club: club,
              isActive: isActive,
              onTap: () => _onClubTap(club),
              onLongPress: () => _onClubLongPress(club),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.groups_outlined,
            size: 80,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 24),
          Text(
            'No clubs yet',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Join a club or create one to get started',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Failed to load clubs',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () {
              ref.read(clubsListProvider.notifier).fetchClubs();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  void _onCreateClub() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Create club - Coming soon')),
    );
  }

  void _onClubTap(Club club) {
    // Navigate to club detail screen (future)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening ${club.name} details...')),
    );
  }

  void _onClubLongPress(Club club) {
    _showSwitchClubDialog(club);
  }

  void _showSwitchClubDialog(Club club) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Switch Club'),
        content: Text('Switch to ${club.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(activeClubProvider.notifier).setActiveClub(club.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Switched to ${club.name}')),
              );
            },
            child: const Text('Switch'),
          ),
        ],
      ),
    );
  }
}
