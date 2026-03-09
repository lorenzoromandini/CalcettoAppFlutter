import 'package:flutter/material.dart';
import 'package:calcetto_app/features/clubs/domain/entities/club.dart';

/// Displays role-appropriate icon for club members.
///
/// Visual indicators:
/// - OWNER: Gold star (Icons.stars)
/// - MANAGER: Blue shield (Icons.shield)
/// - MEMBER: Grey person (Icons.person)
class RoleIcon extends StatelessWidget {
  final ClubRole role;
  final double size;

  const RoleIcon({
    super.key,
    required this.role,
    this.size = 24,
  });

  IconData get _icon {
    switch (role) {
      case ClubRole.owner:
        return Icons.stars;
      case ClubRole.manager:
        return Icons.shield;
      case ClubRole.member:
        return Icons.person;
    }
  }

  Color get _color {
    switch (role) {
      case ClubRole.owner:
        return Colors.amber;
      case ClubRole.manager:
        return Colors.blue;
      case ClubRole.member:
        return Colors.grey;
    }
  }

  String get _roleName {
    switch (role) {
      case ClubRole.owner:
        return 'Owner';
      case ClubRole.manager:
        return 'Manager';
      case ClubRole.member:
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
