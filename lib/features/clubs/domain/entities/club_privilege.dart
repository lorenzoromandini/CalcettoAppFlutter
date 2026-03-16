import 'package:hive_flutter/hive_flutter.dart';

part 'club_privilege.g.dart';

/// Club privilege enum representing management level in a club.
/// Maps to Serverpod ClubPrivilege enum: OWNER=0, MANAGER=1, MEMBER=2
@HiveType(typeId: 5)
enum ClubPrivilege {
  @HiveField(0)
  OWNER,
  @HiveField(1)
  MANAGER,
  @HiveField(2)
  MEMBER;

  /// Returns display name for the privilege.
  String get displayName {
    switch (this) {
      case ClubPrivilege.OWNER:
        return 'Proprietario';
      case ClubPrivilege.MANAGER:
        return 'Manager';
      case ClubPrivilege.MEMBER:
        return 'Membro';
    }
  }

  /// Returns true if privilege has admin rights (OWNER or MANAGER).
  bool get isAdmin =>
      this == ClubPrivilege.OWNER || this == ClubPrivilege.MANAGER;

  /// Returns true if can manage club settings (OWNER only).
  bool get canManageClub => this == ClubPrivilege.OWNER;

  /// Returns true if can manage matches (OWNER or MANAGER).
  bool get canManageMatches =>
      this == ClubPrivilege.OWNER || this == ClubPrivilege.MANAGER;

  /// Maps from Serverpod ClubPrivilege index
  static ClubPrivilege fromIndex(int index) {
    switch (index) {
      case 0:
        return ClubPrivilege.OWNER;
      case 1:
        return ClubPrivilege.MANAGER;
      case 2:
      default:
        return ClubPrivilege.MEMBER;
    }
  }

  /// Maps from Serverpod ClubPrivilege name
  static ClubPrivilege fromName(String name) {
    switch (name.toUpperCase()) {
      case 'OWNER':
        return ClubPrivilege.OWNER;
      case 'MANAGER':
        return ClubPrivilege.MANAGER;
      case 'MEMBER':
      default:
        return ClubPrivilege.MEMBER;
    }
  }
}
