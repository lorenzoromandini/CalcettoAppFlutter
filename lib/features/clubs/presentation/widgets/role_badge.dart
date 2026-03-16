import 'package:flutter/material.dart';
import '../../domain/entities/club_privilege.dart';

/// Widget displaying a user's privilege in a club.
///
/// Shows a Material 3 Chip with privilege-specific colors:
/// - OWNER: Gold/amber
/// - MANAGER: Blue
/// - MEMBER: Grey/neutral
class RoleBadge extends StatelessWidget {
  final ClubPrivilege privilege;

  const RoleBadge({
    super.key,
    required this.privilege,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Chip(
      label: Text(
        _getPrivilegeName(privilege),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 10,
            ),
      ),
      backgroundColor: _getPrivilegeColor(colorScheme),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }

  String _getPrivilegeName(ClubPrivilege privilege) {
    switch (privilege) {
      case ClubPrivilege.OWNER:
        return 'OWNER';
      case ClubPrivilege.MANAGER:
        return 'MANAGER';
      case ClubPrivilege.MEMBER:
        return 'MEMBER';
    }
  }

  Color _getPrivilegeColor(ColorScheme colorScheme) {
    switch (privilege) {
      case ClubPrivilege.OWNER:
        return Colors.amber.shade100;
      case ClubPrivilege.MANAGER:
        return Colors.blue.shade100;
      case ClubPrivilege.MEMBER:
        return colorScheme.surfaceContainerHighest;
    }
  }
}
