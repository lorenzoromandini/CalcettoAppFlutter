import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:calcetto_app/features/clubs/domain/entities/club.dart';
import 'package:calcetto_app/features/clubs/presentation/widgets/club_info_tab.dart';
import 'package:calcetto_app/features/clubs/presentation/screens/club_members_screen.dart';
import 'package:calcetto_app/features/clubs/presentation/widgets/invite_code_generator.dart';
import 'package:calcetto_app/features/clubs/presentation/providers/club_members_provider.dart';
import 'package:calcetto_app/core/di/injection.dart';
import 'package:calcetto_app/features/clubs/domain/repositories/clubs_repository.dart';

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
    final role = widget.club.userRole;
    return role == ClubRole.owner || role == ClubRole.manager;
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
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: _handleShare,
              tooltip: 'Share invite code',
            ),
          PopupMenuButton<String>(
            onSelected: (value) {
              // Future: edit club, leave club
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(width: 8),
                    Text('Edit club'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'leave',
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app),
                    SizedBox(width: 8),
                    Text('Leave club'),
                  ],
                ),
              ),
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
        ),
      ),
      body: Column(
        children: [
          // Offline indicator
          Consumer(
            builder: (context, ref, child) {
              final isOnlineAsync = ref.watch(isOnlineProvider);
              final isOnline = isOnlineAsync.value ?? true;
              if (!isOnline) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  color: theme.colorScheme.secondaryContainer,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.cloud_off,
                        size: 16,
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Offline - Showing cached data',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSecondaryContainer,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Info tab
                ClubInfoTab(club: widget.club),
                // Members tab
                ClubMembersTab(clubId: widget.club.id),
                // Matches tab (placeholder for Phase 3)
                _buildMatchesPlaceholder(),
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
