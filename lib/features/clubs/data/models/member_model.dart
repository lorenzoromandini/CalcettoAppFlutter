import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/member.dart';
import '../../domain/entities/club_privilege.dart';

part 'member_model.g.dart';

/// Data model for Member with Hive adapter support.
///
/// Converts to/from Member entity for domain layer compatibility.
/// NOTE: This model uses ClubPrivilege (not ClubRole) for the user's privilege level.
@HiveType(typeId: 3)
@JsonSerializable()
class MemberModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? avatarUrl;

  @HiveField(3)
  final ClubPrivilege privilege;

  @HiveField(4)
  final DateTime joinedAt;

  @HiveField(5)
  final MemberStatsModel? stats;

  @HiveField(6)
  final DateTime? cachedAt;

  MemberModel({
    required this.id,
    required this.name,
    this.avatarUrl,
    required this.privilege,
    required this.joinedAt,
    this.stats,
    this.cachedAt,
  });

  /// Creates a MemberModel from a Member entity.
  factory MemberModel.fromEntity(Member entity) => MemberModel(
        id: entity.id,
        name: entity.name,
        avatarUrl: entity.avatarUrl,
        privilege: entity.privilege,
        joinedAt: entity.joinedAt,
        stats: entity.stats != null
            ? MemberStatsModel(
                matchesPlayed: entity.stats!.matchesPlayed,
                goals: entity.stats!.goals,
                assists: entity.stats!.assists,
                rating: entity.stats!.rating,
              )
            : null,
      );

  /// Converts this MemberModel to its entity representation.
  Member toEntity() => Member(
        id: id,
        name: name,
        avatarUrl: avatarUrl,
        privilege: privilege,
        joinedAt: joinedAt,
        stats: stats != null
            ? MemberStats(
                matchesPlayed: stats!.matchesPlayed,
                goals: stats!.goals,
                assists: stats!.assists,
                rating: stats!.rating,
              )
            : null,
      );

  /// Creates a MemberModel from a JSON map.
  /// Handles API returning privilege as int (0=OWNER, 1=MANAGER, 2=MEMBER)
  factory MemberModel.fromJson(Map<String, dynamic> json) {
    // Handle privilege as int from API
    final privilegeValue = json['privilege'];
    ClubPrivilege privilege;
    if (privilegeValue is int) {
      privilege = ClubPrivilege.fromIndex(privilegeValue);
    } else if (privilegeValue is String) {
      privilege = ClubPrivilege.fromName(privilegeValue);
    } else {
      privilege = ClubPrivilege.MEMBER;
    }

    return MemberModel(
      id: json['id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      privilege: privilege,
      joinedAt: json['joinedAt'] != null
          ? DateTime.parse(json['joinedAt'] as String)
          : DateTime.now(),
      stats: json['stats'] == null
          ? null
          : MemberStatsModel.fromJson(json['stats'] as Map<String, dynamic>),
      cachedAt: json['cachedAt'] == null
          ? null
          : DateTime.parse(json['cachedAt'] as String),
    );
  }

  /// Converts this MemberModel to a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'avatarUrl': avatarUrl,
        'privilege': privilege.index, // Send as int to API
        'joinedAt': joinedAt.toIso8601String(),
        'stats': stats?.toJson(),
        'cachedAt': cachedAt?.toIso8601String(),
      };

  /// Creates a MemberModel with cache timestamp.
  factory MemberModel.withTimestamp(MemberModel model, DateTime timestamp) =>
      MemberModel(
        id: model.id,
        name: model.name,
        avatarUrl: model.avatarUrl,
        privilege: model.privilege,
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
