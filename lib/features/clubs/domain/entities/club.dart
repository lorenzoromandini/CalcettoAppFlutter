import 'package:freezed_annotation/freezed_annotation.dart';

part 'club.freezed.dart';
part 'club.g.dart';

/// Club role enum representing user's permission level in a club.
enum ClubRole {
  owner,
  manager,
  member;

  /// Returns display name for the role.
  String get displayName {
    switch (this) {
      case ClubRole.owner:
        return 'Owner';
      case ClubRole.manager:
        return 'Manager';
      case ClubRole.member:
        return 'Member';
    }
  }

  /// Returns true if role has admin privileges (OWNER or MANAGER).
  bool get isAdmin => this == ClubRole.owner || this == ClubRole.manager;
}

/// Immutable Club entity representing a football club.
///
/// Contains basic club information displayed in club lists and details.
@freezed
class Club with _$Club {
  const factory Club({
    required String id,
    required String name,
    String? logoUrl,
    required int memberCount,
    required ClubRole userRole,
    String? description,
    required DateTime createdAt,
  }) = _Club;

  /// Creates a Club from a JSON map (for deserialization).
  factory Club.fromJson(Map<String, dynamic> json) => _$ClubFromJson(json);
}
