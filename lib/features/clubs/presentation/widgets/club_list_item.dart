import 'package:flutter/material.dart';
import '../../domain/entities/club.dart';
import 'role_badge.dart';

/// Individual club list item widget.
///
/// Displays club information with:
/// - Club logo (leading)
/// - Club name and member count
/// - Role badge and active indicator (trailing)
///
/// Long-press support for club switching.
class ClubListItem extends StatelessWidget {
  final Club club;
  final bool isActive;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const ClubListItem({
    super.key,
    required this.club,
    required this.isActive,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      onTap: onTap,
      onLongPress: onLongPress,
      selected: isActive,
      selectedTileColor: colorScheme.surfaceContainerHighest,
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: colorScheme.surfaceContainerHighest,
        backgroundImage:
            club.logoUrl != null ? NetworkImage(club.logoUrl!) : null,
        child: club.logoUrl == null
            ? Icon(
                Icons.sports_soccer,
                color: colorScheme.onSurfaceVariant,
              )
            : null,
      ),
      title: Text(
        club.name,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        '${club.memberCount} members',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          RoleBadge(role: club.userRole),
          if (isActive) ...[
            const SizedBox(width: 8),
            Icon(
              Icons.star,
              color: Colors.amber,
              size: 20,
            ),
          ],
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}
