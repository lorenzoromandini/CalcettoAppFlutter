import 'package:flutter/material.dart';
import 'package:calcetto_app/features/clubs/domain/entities/member.dart';
import 'package:calcetto_app/features/clubs/domain/entities/club_privilege.dart';

/// Screen for displaying detailed member information.
///
/// Shows member profile, stats, and club information.
class MemberDetailScreen extends StatelessWidget {
  final Member member;

  const MemberDetailScreen({
    super.key,
    required this.member,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(member.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar
            CircleAvatar(
              radius: 60,
              backgroundColor: theme.colorScheme.primaryContainer,
              backgroundImage: member.avatarUrl != null
                  ? NetworkImage(member.avatarUrl!)
                  : null,
              child: member.avatarUrl == null
                  ? Text(
                      member.name.substring(0, 1).toUpperCase(),
                      style: theme.textTheme.displayLarge?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    )
                  : null,
            ),
            const SizedBox(height: 16),
            // Name
            Text(
              member.name,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            // Privilege badge
            _buildPrivilegeBadge(theme),
            const SizedBox(height: 24),
            // Join date
            _buildInfoCard(
              theme,
              icon: Icons.calendar_today,
              label: 'Joined',
              value: _formatDate(member.joinedAt),
            ),
            const SizedBox(height: 16),
            // Stats section
            if (member.stats != null) ...[
              Text(
                'Statistics',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildStatsGrid(theme),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPrivilegeBadge(ThemeData theme) {
    final (color, label) = switch (member.privilege) {
      ClubPrivilege.OWNER => (Colors.amber, 'Proprietario'),
      ClubPrivilege.MANAGER => (Colors.blue, 'Manager'),
      ClubPrivilege.MEMBER => (Colors.grey, 'Membro'),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 2),
      ),
      child: Text(
        label,
        style: theme.textTheme.titleMedium?.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    ThemeData theme, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: theme.colorScheme.primary),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  value,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid(ThemeData theme) {
    final stats = member.stats!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildStatRow(
              theme,
              icon: Icons.sports_soccer,
              label: 'Matches Played',
              value: '${stats.matchesPlayed}',
            ),
            const Divider(),
            _buildStatRow(
              theme,
              icon: Icons.star,
              label: 'Rating',
              value: stats.rating?.toStringAsFixed(1) ?? '-',
            ),
            const Divider(),
            _buildStatRow(
              theme,
              icon: Icons.emoji_events,
              label: 'Goals',
              value: '${stats.goals}',
            ),
            const Divider(),
            _buildStatRow(
              theme,
              icon: Icons.assist_walker,
              label: 'Assists',
              value: '${stats.assists}',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(
    ThemeData theme, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyLarge,
            ),
          ),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}
