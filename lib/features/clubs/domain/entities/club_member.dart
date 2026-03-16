import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'club_privilege.dart';
import 'player_position.dart';

part 'club_member.freezed.dart';
part 'club_member.g.dart';

/// Immutable ClubMember entity representing a club membership.
///
/// Contains:
/// - User info (id, name, avatar)
/// - Player position (primary + secondary roles)
/// - Club privilege (OWNER/MANAGER/MEMBER)
/// - Membership metadata (joinedAt, jerseyNumber, etc.)
@freezed
class ClubMember with _$ClubMember {
  const factory ClubMember({
    required String id,
    required String userId,
    required String clubId,
    required String name,
    String? avatarUrl,

    // Player position on the field
    required PlayerPosition primaryPosition,
    @Default([]) List<PlayerPosition> secondaryPositions,

    // Management privilege in the club
    required ClubPrivilege privilege,

    // Membership details
    required DateTime joinedAt,
    int? jerseyNumber,
    String? symbol,
    String? nationality,

    // Statistics (Phase 4)
    ClubMemberStats? stats,
  }) = _ClubMember;

  /// Creates a ClubMember from a JSON map.
  factory ClubMember.fromJson(Map<String, dynamic> json) =>
      _$ClubMemberFromJson(json);
}

/// Club member statistics for Phase 4.
@freezed
class ClubMemberStats with _$ClubMemberStats {
  const factory ClubMemberStats({
    @Default(0) int matchesPlayed,
    @Default(0) int goals,
    @Default(0) int assists,
    double? averageRating,
  }) = _ClubMemberStats;

  /// Creates ClubMemberStats from JSON.
  factory ClubMemberStats.fromJson(Map<String, dynamic> json) =>
      _$ClubMemberStatsFromJson(json);
}
