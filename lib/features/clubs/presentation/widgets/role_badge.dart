import 'package:flutter/material.dart';
import '../../domain/entities/club.dart';

/// Widget displaying a user's role in a club.
///
/// Shows a Material 3 Chip with role-specific colors:
/// - OWNER: Gold/amber
/// - MANAGER: Blue
/// - MEMBER: Grey/neutral
class RoleBadge extends StatelessWidget {
  final ClubRole role;

  const RoleBadge({
    super.key,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Chip(
      label: Text(
        _getRoleName(role),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 10,
            ),
      ),
      backgroundColor: _getRoleColor(colorScheme),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }

  String _getRoleName(ClubRole role) {
    switch (role) {
      case ClubRole.owner:
        return 'OWNER';
      case ClubRole.manager:
        return 'MANAGER';
      case ClubRole.member:
        return 'MEMBER';
    }
  }

  Color _getRoleColor(ColorScheme colorScheme) {
    switch (role) {
      case ClubRole.owner:
        return Colors.amber.shade100;
      case ClubRole.manager:
        return Colors.blue.shade100;
      case ClubRole.member:
        return colorScheme.surfaceContainerHighest;
    }
  }
}
