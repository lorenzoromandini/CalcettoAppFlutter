import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/club_privilege.dart';
import '../../domain/entities/player_position.dart';

part 'club_member_model.g.dart';

/// Data model for ClubMember with Hive adapter support.
///
/// Converts to/from ClubMember entity for domain layer compatibility.
/// Separates:
/// - Player position (primary + secondary roles)
/// - Club privilege (OWNER/MANAGER/MEMBER)
@HiveType(typeId: 3)
@JsonSerializable()
class ClubMemberModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final String clubId;

  @HiveField(3)
  final String name;

  @HiveField(4)
  final String? avatarUrl;

  @HiveField(5)
  final PlayerPosition primaryPosition;

  @HiveField(6)
  final List<PlayerPosition> secondaryPositions;

  @HiveField(7)
  final ClubPrivilege privilege;

  @HiveField(8)
  final DateTime joinedAt;

  @HiveField(9)
  final int? jerseyNumber;

  @HiveField(10)
  final String? symbol;

  @HiveField(11)
  final String? nationality;

  @HiveField(12)
  final ClubMemberStatsModel? stats;

  @HiveField(13)
  final DateTime? cachedAt;

  ClubMemberModel({
    required this.id,
    required this.userId,
    required this.clubId,
    required this.name,
    this.avatarUrl,
    required this.primaryPosition,
    this.secondaryPositions = const [],
    required this.privilege,
    required this.joinedAt,
    this.jerseyNumber,
    this.symbol,
    this.nationality,
    this.stats,
    this.cachedAt,
  });

  /// Creates a ClubMemberModel from JSON (API response).
  factory ClubMemberModel.fromJson(Map<String, dynamic> json) =>
      _$ClubMemberModelFromJson(json);

  /// Converts to JSON map.
  Map<String, dynamic> toJson() => _$ClubMemberModelToJson(this);

  /// Creates a copy with cache timestamp.
  ClubMemberModel withTimestamp(DateTime timestamp) => ClubMemberModel(
        id: id,
        userId: userId,
        clubId: clubId,
        name: name,
        avatarUrl: avatarUrl,
        primaryPosition: primaryPosition,
        secondaryPositions: secondaryPositions,
        privilege: privilege,
        joinedAt: joinedAt,
        jerseyNumber: jerseyNumber,
        symbol: symbol,
        nationality: nationality,
        stats: stats,
        cachedAt: timestamp,
      );
}

/// Data model for ClubMember statistics.
@HiveType(typeId: 4)
@JsonSerializable()
class ClubMemberStatsModel {
  @HiveField(0)
  final int matchesPlayed;

  @HiveField(1)
  final int goals;

  @HiveField(2)
  final int assists;

  @HiveField(3)
  final double? averageRating;

  ClubMemberStatsModel({
    this.matchesPlayed = 0,
    this.goals = 0,
    this.assists = 0,
    this.averageRating,
  });

  factory ClubMemberStatsModel.fromJson(Map<String, dynamic> json) =>
      _$ClubMemberStatsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClubMemberStatsModelToJson(this);
}
