import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:calcetto_app/features/clubs/domain/entities/club.dart';
import 'package:calcetto_app/features/clubs/domain/entities/club_privilege.dart';
import 'package:calcetto_app/features/clubs/presentation/widgets/club_info_tab.dart';
import 'package:calcetto_app/features/clubs/presentation/screens/club_members_screen.dart';
import 'package:calcetto_app/features/clubs/presentation/screens/edit_club_screen.dart';
import 'package:calcetto_app/features/clubs/presentation/widgets/invite_code_generator.dart';
import 'package:calcetto_app/features/clubs/presentation/widgets/delete_club_dialog.dart';
import 'package:calcetto_app/features/clubs/presentation/providers/club_members_provider.dart';
import 'package:calcetto_app/features/clubs/domain/repositories/clubs_repository.dart';
import 'package:calcetto_app/core/di/injection.dart';
import '../../../../core/providers/offline_status_provider.dart';
import '../../../../core/widgets/offline_indicator.dart';
import '../../presentation/providers/active_club_provider.dart';

/// Club detail screen with tabs for Info, Members, and Matches
class ClubDetailScreen extends ConsumerStatefulWidget {
  final Club club;

  const ClubDetailScreen({
    super.key,
    required this.club,
  });

  @override
  ConsumerState<ClubDetailScreen> createState() => _ClubDetailScreenState();
}

class _ClubDetailScreenState extends ConsumerState<ClubDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool get _isAdmin {
    final privilege = widget.club.userPrivilege;
    return privilege == ClubPrivilege.OWNER ||
        privilege == ClubPrivilege.MANAGER;
  }

  bool get _isOwner => widget.club.userPrivilege == ClubPrivilege.OWNER;

  bool _isOffline(WidgetRef ref) {
    return ref.watch(isOfflineProvider);
  }

  Future<void> _refreshData() async {
    // Refresh active club data
    await ref.read(activeClubProvider.notifier).initialize();
  }

  Future<void> _handleShare() async {
    if (!_isAdmin) return;

    // Show centered semi-transparent invite dialog
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (context) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            constraints: const BoxConstraints(maxWidth: 400),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface.withOpacity(0.95),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_add,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Invita Membri',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),
                // Content
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: InviteCodeGenerator(
                    clubId: widget.club.id,
                    userPrivilege: widget.club.userPrivilege,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: _isAdmin
            ? Consumer(
                builder: (context, ref, _) {
                  final isOffline = _isOffline(ref);
                  return Tooltip(
                    message: isOffline
                        ? 'Requires internet connection'
                        : 'Share invite code',
                    child: IgnorePointer(
                      ignoring: isOffline,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: isOffline ? 0.5 : 1.0,
                        child: IconButton(
                          icon: const Icon(Icons.share),
                          onPressed: isOffline ? null : _handleShare,
                          tooltip: 'Share invite code',
                        ),
                      ),
                    ),
                  );
                },
              )
            : null,
        title: Text(
          widget.club.name,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (_isOwner)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditClubScreen(club: widget.club),
                  ),
                );
              },
              tooltip: 'Modifica club',
            ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.info_outline),
              text: 'Info',
            ),
            Tab(
              icon: Icon(Icons.people),
              text: 'Members',
            ),
            Tab(
              icon: Icon(Icons.sports_soccer),
              text: 'Matches',
            ),
          ],
          onTap: (index) {
            // Tab tapped
          },
        ),
      ),
      body: Column(
        children: [
          // Offline indicator
          const OfflineIndicator(),
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Info tab with pull-to-refresh
                RefreshIndicator(
                  onRefresh: _refreshData,
                  child: ClubInfoTab(club: widget.club),
                ),
                // Members tab with pull-to-refresh
                RefreshIndicator(
                  onRefresh: _refreshData,
                  child: ClubMembersTab(clubId: widget.club.id),
                ),
                // Matches tab with pull-to-refresh (placeholder for Phase 3)
                RefreshIndicator(
                  onRefresh: _refreshData,
                  child: _buildMatchesPlaceholder(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchesPlaceholder() {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.sports_soccer,
            size: 64,
            color: theme.colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 24),
          Text(
            'Match Schedule',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Coming in Phase 3',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'View upcoming matches,\nRSVP, and track live games',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
