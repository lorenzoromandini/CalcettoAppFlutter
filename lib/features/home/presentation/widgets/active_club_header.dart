import 'package:flutter/material.dart';
import 'package:calcetto_app/features/clubs/domain/entities/club.dart';
import '../../../clubs/presentation/widgets/role_icon.dart';

/// Active club header widget showing current club context.
///
/// Features:
/// - Club logo (40px, circular)
/// - Club name (titleMedium, bold)
/// - User's role with role icon
/// - Chevron icon for switching (tap to open switcher)
/// - Material 3 card style
///
/// Tappable to open club switcher or navigate to clubs list.
class ActiveClubHeader extends StatelessWidget {
  final Club club;
  final VoidCallback? onTap;

  const ActiveClubHeader({
    super.key,
    required this.club,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.all(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Club logo
              ClipOval(
                child: Image.network(
                  club.logoUrl ?? '',
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.sports_soccer,
                        color: theme.colorScheme.onPrimaryContainer,
                        size: 20,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              // Club info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      club.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        RoleIcon(role: club.userRole, size: 14),
                        const SizedBox(width: 6),
                        Text(
                          _getRoleName(club.userRole),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Chevron
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getRoleName(ClubRole role) {
    switch (role) {
      case ClubRole.owner:
        return 'Owner';
      case ClubRole.manager:
        return 'Manager';
      case ClubRole.member:
        return 'Member';
    }
  }
}
