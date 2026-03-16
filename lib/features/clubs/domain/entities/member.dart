import 'package:freezed_annotation/freezed_annotation.dart';

import 'club_privilege.dart';

part 'member.freezed.dart';
part 'member.g.dart';

/// Immutable Member entity representing a club member.
///
/// Contains member profile information and privilege level within the club.
/// Uses ClubPrivilege (OWNER/MANAGER/MEMBER) for management level.
@freezed
class Member with _$Member {
  const factory Member({
    required String id,
    required String name,
    String? avatarUrl,
    required ClubPrivilege privilege,
    required DateTime joinedAt,
    MemberStats? stats,
  }) = _Member;

  /// Creates a Member from a JSON map.
  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
}

/// Member statistics for Phase 4 (placeholder for Phase 2).
@freezed
class MemberStats with _$MemberStats {
  const factory MemberStats({
    @Default(0) int matchesPlayed,
    @Default(0) int goals,
    @Default(0) int assists,
    double? rating,
  }) = _MemberStats;

  /// Creates MemberStats from JSON.
  factory MemberStats.fromJson(Map<String, dynamic> json) =>
      _$MemberStatsFromJson(json);
}
