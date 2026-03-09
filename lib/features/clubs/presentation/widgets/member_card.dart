import 'package:flutter/material.dart';
import 'package:calcetto_app/features/clubs/domain/entities/member.dart';
import 'package:calcetto_app/features/clubs/domain/entities/club.dart';
import 'package:calcetto_app/features/clubs/presentation/widgets/role_icon.dart';

/// FIFA-style player card for displaying club members.
///
/// Features:
/// - Gradient background based on role (OWNER=gold, MANAGER=blue, MEMBER=silver)
/// - Avatar and role icon at top
/// - Member name and join date
/// - Stats preview (matches, goals, rating)
/// - Tappable with scale animation
class MemberCard extends StatelessWidget {
  final Member member;
  final VoidCallback? onTap;

  const MemberCard({
    super.key,
    required this.member,
    this.onTap,
  });

  LinearGradient _getGradient() {
    switch (member.role) {
      case ClubRole.owner:
        return LinearGradient(
          colors: [Colors.amber[200]!, Colors.amber[700]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case ClubRole.manager:
        return LinearGradient(
          colors: [Colors.blue[200]!, Colors.blue[700]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case ClubRole.member:
        return LinearGradient(
          colors: [Colors.grey[300]!, Colors.grey[700]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 100),
        tween: Tween<double>(begin: 1.0, end: 1.0),
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: child,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: _getGradient(),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                // Background pattern overlay
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.3),
                        ],
                      ),
                    ),
                  ),
                ),
                // Content
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top section: Avatar + Role icon
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            backgroundImage: member.avatarUrl != null
                                ? NetworkImage(member.avatarUrl!)
                                : null,
                            child: member.avatarUrl == null
                                ? Text(
                                    member.name.substring(0, 1).toUpperCase(),
                                    style:
                                        theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.primary,
                                    ),
                                  )
                                : null,
                          ),
                          const Spacer(),
                          RoleIcon(
                            role: member.role,
                            size: 24,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Middle section: Name
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              member.name,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.5),
                                    offset: const Offset(1, 1),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Joined ${_formatDate(member.joinedAt)}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Bottom section: Stats preview
                      _buildStatsRow(theme),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsRow(ThemeData theme) {
    final stats = member.stats;
    final hasStats = stats != null;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMiniStat(
            Icons.sports_soccer,
            hasStats ? '${stats.matchesPlayed}' : '0',
            theme,
          ),
          _buildMiniStat(
            Icons.star,
            hasStats && stats.rating != null ? '${stats.rating}' : '-',
            theme,
          ),
          _buildMiniStat(
            Icons.emoji_events,
            hasStats ? '${stats.goals}' : '0',
            theme,
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(IconData icon, String value, ThemeData theme) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 12,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(width: 2),
        Text(
          value,
          style: theme.textTheme.bodySmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${months[date.month - 1]} ${date.year}';
  }
}
