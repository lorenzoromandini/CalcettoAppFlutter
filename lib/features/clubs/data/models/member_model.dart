import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/member.dart';
import '../../domain/entities/club.dart';

part 'member_model.g.dart';

/// Data model for Member with Hive adapter support.
///
/// Converts to/from Member entity for domain layer compatibility.
@HiveType(typeId: 1)
@JsonSerializable()
class MemberModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? avatarUrl;

  @HiveField(3)
  final ClubRole role;

  @HiveField(4)
  final DateTime joinedAt;

  @HiveField(5)
  final MemberStats? stats;

  @HiveField(6)
  final DateTime? cachedAt;

  MemberModel({
    required this.id,
    required this.name,
    this.avatarUrl,
    required this.role,
    required this.joinedAt,
    this.stats,
    this.cachedAt,
  });

  /// Creates a MemberModel from a Member entity.
  factory MemberModel.fromEntity(Member entity) => MemberModel(
        id: entity.id,
        name: entity.name,
        avatarUrl: entity.avatarUrl,
        role: entity.role,
        joinedAt: entity.joinedAt,
        stats: entity.stats,
      );

  /// Converts this MemberModel to its entity representation.
  Member toEntity() => Member(
        id: id,
        name: name,
        avatarUrl: avatarUrl,
        role: role,
        joinedAt: joinedAt,
        stats: stats,
      );

  /// Creates a MemberModel from a JSON map.
  factory MemberModel.fromJson(Map<String, dynamic> json) =>
      _$MemberModelFromJson(json);

  /// Converts this MemberModel to a JSON map.
  Map<String, dynamic> toJson() => _$MemberModelToJson(this);

  /// Creates a MemberModel with cache timestamp.
  factory MemberModel.withTimestamp(MemberModel model, DateTime timestamp) =>
      MemberModel(
        id: model.id,
        name: model.name,
        avatarUrl: model.avatarUrl,
        role: model.role,
        joinedAt: model.joinedAt,
        stats: model.stats,
        cachedAt: timestamp,
      );
}

/// Data model for MemberStats with Hive adapter support.
@HiveType(typeId: 2)
@JsonSerializable()
class MemberStatsModel {
  @HiveField(0)
  final int matchesPlayed;

  @HiveField(1)
  final int goals;

  @HiveField(2)
  final int assists;

  @HiveField(3)
  final double? rating;

  MemberStatsModel({
    this.matchesPlayed = 0,
    this.goals = 0,
    this.assists = 0,
    this.rating,
  });

  /// Creates MemberStatsModel from JSON.
  factory MemberStatsModel.fromJson(Map<String, dynamic> json) =>
      _$MemberStatsModelFromJson(json);

  /// Converts to JSON map.
  Map<String, dynamic> toJson() => _$MemberStatsModelToJson(this);
}
