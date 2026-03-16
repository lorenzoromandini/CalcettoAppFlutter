import 'package:flutter/material.dart';
import 'package:calcetto_app/features/clubs/domain/entities/club.dart';
import 'package:calcetto_app/features/clubs/domain/entities/club_privilege.dart';

/// Info tab displaying club details, logo, statistics, and user role.
class ClubInfoTab extends StatelessWidget {
  final Club club;

  const ClubInfoTab({
    super.key,
    required this.club,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RefreshIndicator(
      onRefresh: () async {
        // Pull-to-refresh - for now just triggers a rebuild
        // In production, this would call provider.refresh()
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Club logo
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.primaryContainer,
                  border: Border.all(
                    color: theme.colorScheme.primary,
                    width: 3,
                  ),
                ),
                child: club.logoUrl != null
                    ? ClipOval(
                        child: Image.network(
                          club.logoUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return _buildDefaultLogo(theme);
                          },
                        ),
                      )
                    : _buildDefaultLogo(theme),
              ),
            ),
            const SizedBox(height: 24),

            // Club name
            Text(
              club.name,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // Member count chip
            Center(
              child: InputChip(
                avatar: const Icon(Icons.people),
                label: Text(
                    '${club.memberCount} member${club.memberCount != 1 ? 's' : ''}'),
                backgroundColor: theme.colorScheme.primaryContainer,
                labelStyle: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Description section
            if (club.description != null && club.description!.isNotEmpty) ...[
              _buildSectionCard(
                theme,
                icon: Icons.description,
                title: 'Description',
                child: Text(
                  club.description!,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Statistics summary
            _buildSectionCard(
              theme,
              icon: Icons.analytics,
              title: 'Club Statistics',
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildStatCard(
                    theme,
                    icon: Icons.sports_soccer,
                    value: '0',
                    label: 'Matches Played',
                  ),
                  _buildStatCard(
                    theme,
                    icon: Icons.emoji_events,
                    value: '0%',
                    label: 'Win Rate',
                  ),
                  _buildStatCard(
                    theme,
                    icon: Icons.groups,
                    value: '0',
                    label: 'Avg Attendance',
                  ),
                  _buildStatCard(
                    theme,
                    icon: Icons.calendar_today,
                    value: _formatDate(club.createdAt),
                    label: 'Founded',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // User role section
            _buildRoleSection(theme),
            const SizedBox(height: 16),

            // Club creation date
            Text(
              'Joined ${_formatDate(club.createdAt)}',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultLogo(ThemeData theme) {
    return Center(
      child: Text(
        club.name.substring(0, 1).toUpperCase(),
        style: theme.textTheme.displayLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildSectionCard(
    ThemeData theme, {
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    ThemeData theme, {
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: theme.colorScheme.primary,
            size: 28,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleSection(ThemeData theme) {
    final privilege = club.userPrivilege;
    final isAdmin =
        privilege == ClubPrivilege.OWNER || privilege == ClubPrivilege.MANAGER;

    IconData roleIcon;
    String roleName;
    Color roleColor;

    switch (privilege) {
      case ClubPrivilege.OWNER:
        roleIcon = Icons.stars;
        roleName = 'Owner';
        roleColor = Colors.amber;
        break;
      case ClubPrivilege.MANAGER:
        roleIcon = Icons.shield;
        roleName = 'Manager';
        roleColor = Colors.blue;
        break;
      case ClubPrivilege.MEMBER:
        roleIcon = Icons.person;
        roleName = 'Member';
        roleColor = Colors.grey;
        break;
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.workspaces,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Your Role',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: roleColor.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    roleIcon,
                    color: roleColor,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        roleName,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        isAdmin
                            ? 'Full access to manage club'
                            : 'View club information',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                      if (isAdmin) ...[
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            Chip(
                              avatar: const Icon(Icons.add, size: 18),
                              label: const Text('Invite members'),
                              backgroundColor:
                                  theme.colorScheme.secondaryContainer,
                              labelStyle: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSecondaryContainer,
                              ),
                            ),
                            Chip(
                              avatar: const Icon(Icons.edit, size: 18),
                              label: const Text('Edit club'),
                              backgroundColor:
                                  theme.colorScheme.secondaryContainer,
                              labelStyle: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSecondaryContainer,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
