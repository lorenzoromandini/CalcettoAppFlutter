import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:calcetto_app/features/clubs/domain/entities/club.dart';
import 'package:calcetto_app/features/clubs/domain/entities/club_privilege.dart';
import 'package:calcetto_app/features/clubs/presentation/widgets/club_info_tab.dart';
import 'package:calcetto_app/features/clubs/presentation/screens/club_members_screen.dart';
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
  late ClubsRepository _clubsRepository;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _clubsRepository = ref.read(clubsRepositoryProvider);
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

    // Generate invite code
    final result = await _clubsRepository.generateInviteCode(widget.club.id);

    result.fold(
      (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to generate invite code: $error'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      (code) async {
        // Share the invite code
        await Share.share(
          'Join my football club! Use invite code: $code',
          subject: 'Club Invitation',
          sharePositionOrigin: _getSharePositionOrigin(),
        );
      },
    );
  }

  Rect? _getSharePositionOrigin() {
    final context = this.context;
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final size = renderBox.size;
      final offset = renderBox.localToGlobal(Offset.zero);
      return Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height / 3);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.club.name,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (_isAdmin)
            Consumer(
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
            ),
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'delete' && _isOwner) {
                final result = await showDialog<bool>(
                  context: context,
                  builder: (context) => DeleteClubDialog(
                    clubId: widget.club.id,
                    clubName: widget.club.name,
                  ),
                );

                if (result == true && mounted) {
                  // Navigate back to clubs list
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Club "${widget.club.name}" eliminato'),
                      backgroundColor: theme.colorScheme.primary,
                    ),
                  );
                }
              }
              // Future: edit club
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                enabled: false,
                child: Row(
                  children: [
                    Icon(Icons.edit, color: Colors.grey),
                    SizedBox(width: 8),
                    Text('Modifica club (prossimamente)',
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              if (_isOwner) ...[
                const PopupMenuDivider(),
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Elimina club',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ],
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
