import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/club.dart';
import '../providers/active_club_provider.dart';
import '../providers/clubs_list_provider.dart';

/// Widget showing current active club and allowing switching.
///
/// Tap to open club selection bottom sheet.
/// Used in app drawer or app bar.
class ClubSwitcher extends ConsumerWidget {
  final bool compact;

  const ClubSwitcher({
    super.key,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeClubAsync = ref.watch(activeClubProvider);

    return InkWell(
      onTap: () => _showClubSwitcherSheet(context, ref),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: compact
            ? Row(
                children: [
                  const Icon(Icons.sports_soccer, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        activeClubAsync.when(
                          data: (club) => Text(
                            club?.name ?? 'No club selected',
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          loading: () => const Text(
                            'Loading...',
                            style: TextStyle(fontSize: 14),
                          ),
                          error: (_, __) => const Text('Error'),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Tap to switch',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.expand_more),
                ],
              )
            : activeClubAsync.when(
                data: (club) => _buildExpandedClubInfo(context, club),
                loading: () => _buildLoadingState(context),
                error: (_, __) => _buildErrorState(context),
              ),
      ),
    );
  }

  Widget _buildExpandedClubInfo(BuildContext context, Club? club) {
    if (club == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('No active club',
              style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text('Select a club', style: Theme.of(context).textTheme.bodySmall),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.sports_soccer, size: 24),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                club.name,
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          '${club.memberCount} members • ${club.userPrivilege.displayName}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        Text(
          'Tap to switch club',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
      ],
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return const Row(
      children: [
        CircularProgressIndicator(strokeWidth: 2),
        SizedBox(width: 12),
        Text('Loading club...'),
      ],
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Text(
      'Failed to load club',
      style: TextStyle(color: Theme.of(context).colorScheme.error),
    );
  }

  void _showClubSwitcherSheet(BuildContext context, WidgetRef ref) {
    final clubsAsync = ref.watch(clubsListProvider).value;

    if (clubsAsync == null || clubsAsync.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No clubs available')),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => ClubSwitcherSheet(clubs: clubsAsync),
    );
  }
}

/// Bottom sheet for club selection.
///
/// Shows all available clubs with radio button selection.
class ClubSwitcherSheet extends ConsumerWidget {
  final List<Club> clubs;

  const ClubSwitcherSheet({super.key, required this.clubs});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeClubAsync = ref.read(activeClubProvider).value;
    final activeClubId = activeClubAsync?.id;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Select Club',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Choose the club to view',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Divider(height: 32),
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: clubs.length,
            itemBuilder: (context, index) {
              final club = clubs[index];
              final isActive = club.id == activeClubId;

              return RadioListTile<Club>(
                value: club,
                groupValue: activeClubId != null
                    ? clubs.firstWhere((c) => c.id == activeClubId)
                    : null,
                title: Text(club.name),
                subtitle: Text('${club.memberCount} members'),
                onChanged: (value) {
                  Navigator.pop(context);
                  ref.read(activeClubProvider.notifier).setActiveClub(club.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Switched to ${club.name}')),
                  );
                },
                selected: isActive,
              );
            },
          ),
        ],
      ),
    );
  }
}
