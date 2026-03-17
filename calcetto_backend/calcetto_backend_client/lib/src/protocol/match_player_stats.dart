/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class MatchPlayerStats implements _i1.SerializableModel {
  MatchPlayerStats._({
    this.id,
    required this.matchId,
    required this.clubMemberId,
    int? goalsOpen,
    int? goalsPenalty,
    int? assists,
    int? ownGoals,
    int? penaltiesMissed,
    int? penaltiesSaved,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : goalsOpen = goalsOpen ?? 0,
        goalsPenalty = goalsPenalty ?? 0,
        assists = assists ?? 0,
        ownGoals = ownGoals ?? 0,
        penaltiesMissed = penaltiesMissed ?? 0,
        penaltiesSaved = penaltiesSaved ?? 0,
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory MatchPlayerStats({
    _i1.UuidValue? id,
    required _i1.UuidValue matchId,
    required _i1.UuidValue clubMemberId,
    int? goalsOpen,
    int? goalsPenalty,
    int? assists,
    int? ownGoals,
    int? penaltiesMissed,
    int? penaltiesSaved,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _MatchPlayerStatsImpl;

  factory MatchPlayerStats.fromJson(Map<String, dynamic> jsonSerialization) {
    return MatchPlayerStats(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      matchId:
          _i1.UuidValueJsonExtension.fromJson(jsonSerialization['matchId']),
      clubMemberId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['clubMemberId']),
      goalsOpen: jsonSerialization['goalsOpen'] as int,
      goalsPenalty: jsonSerialization['goalsPenalty'] as int,
      assists: jsonSerialization['assists'] as int,
      ownGoals: jsonSerialization['ownGoals'] as int,
      penaltiesMissed: jsonSerialization['penaltiesMissed'] as int,
      penaltiesSaved: jsonSerialization['penaltiesSaved'] as int,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue matchId;

  _i1.UuidValue clubMemberId;

  int goalsOpen;

  int goalsPenalty;

  int assists;

  int ownGoals;

  int penaltiesMissed;

  int penaltiesSaved;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [MatchPlayerStats]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MatchPlayerStats copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? matchId,
    _i1.UuidValue? clubMemberId,
    int? goalsOpen,
    int? goalsPenalty,
    int? assists,
    int? ownGoals,
    int? penaltiesMissed,
    int? penaltiesSaved,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      'matchId': matchId.toJson(),
      'clubMemberId': clubMemberId.toJson(),
      'goalsOpen': goalsOpen,
      'goalsPenalty': goalsPenalty,
      'assists': assists,
      'ownGoals': ownGoals,
      'penaltiesMissed': penaltiesMissed,
      'penaltiesSaved': penaltiesSaved,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MatchPlayerStatsImpl extends MatchPlayerStats {
  _MatchPlayerStatsImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue matchId,
    required _i1.UuidValue clubMemberId,
    int? goalsOpen,
    int? goalsPenalty,
    int? assists,
    int? ownGoals,
    int? penaltiesMissed,
    int? penaltiesSaved,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          matchId: matchId,
          clubMemberId: clubMemberId,
          goalsOpen: goalsOpen,
          goalsPenalty: goalsPenalty,
          assists: assists,
          ownGoals: ownGoals,
          penaltiesMissed: penaltiesMissed,
          penaltiesSaved: penaltiesSaved,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [MatchPlayerStats]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MatchPlayerStats copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? matchId,
    _i1.UuidValue? clubMemberId,
    int? goalsOpen,
    int? goalsPenalty,
    int? assists,
    int? ownGoals,
    int? penaltiesMissed,
    int? penaltiesSaved,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MatchPlayerStats(
      id: id is _i1.UuidValue? ? id : this.id,
      matchId: matchId ?? this.matchId,
      clubMemberId: clubMemberId ?? this.clubMemberId,
      goalsOpen: goalsOpen ?? this.goalsOpen,
      goalsPenalty: goalsPenalty ?? this.goalsPenalty,
      assists: assists ?? this.assists,
      ownGoals: ownGoals ?? this.ownGoals,
      penaltiesMissed: penaltiesMissed ?? this.penaltiesMissed,
      penaltiesSaved: penaltiesSaved ?? this.penaltiesSaved,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
