import 'package:flutter/material.dart';
import 'package:calcetto_app/features/clubs/domain/entities/club_privilege.dart';

/// Displays privilege-appropriate icon for club members.
///
/// Visual indicators:
/// - OWNER: Gold star (Icons.stars)
/// - MANAGER: Blue shield (Icons.shield)
/// - MEMBER: Grey person (Icons.person)
class RoleIcon extends StatelessWidget {
  final ClubPrivilege privilege;
  final double size;

  const RoleIcon({
    super.key,
    required this.privilege,
    this.size = 24,
  });

  IconData get _icon {
    switch (privilege) {
      case ClubPrivilege.OWNER:
        return Icons.stars;
      case ClubPrivilege.MANAGER:
        return Icons.shield;
      case ClubPrivilege.MEMBER:
        return Icons.person;
    }
  }

  Color get _color {
    switch (privilege) {
      case ClubPrivilege.OWNER:
        return Colors.amber;
      case ClubPrivilege.MANAGER:
        return Colors.blue;
      case ClubPrivilege.MEMBER:
        return Colors.grey;
    }
  }

  String get _roleName {
    switch (privilege) {
      case ClubPrivilege.OWNER:
        return 'Owner';
      case ClubPrivilege.MANAGER:
        return 'Manager';
      case ClubPrivilege.MEMBER:
        return 'Member';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: _roleName,
      child: Icon(
        _icon,
        size: size,
        color: _color,
      ),
    );
  }
}
