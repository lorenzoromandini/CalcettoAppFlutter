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
import 'match_team_side.dart' as _i2;
import 'player_position.dart' as _i3;

abstract class MatchParticipant implements _i1.SerializableModel {
  MatchParticipant._({
    this.id,
    required this.matchId,
    required this.clubMemberId,
    required this.teamSide,
    this.position,
  });

  factory MatchParticipant({
    _i1.UuidValue? id,
    required _i1.UuidValue matchId,
    required _i1.UuidValue clubMemberId,
    required _i2.MatchTeamSide teamSide,
    _i3.PlayerPosition? position,
  }) = _MatchParticipantImpl;

  factory MatchParticipant.fromJson(Map<String, dynamic> jsonSerialization) {
    return MatchParticipant(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      matchId:
          _i1.UuidValueJsonExtension.fromJson(jsonSerialization['matchId']),
      clubMemberId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['clubMemberId']),
      teamSide:
          _i2.MatchTeamSide.fromJson((jsonSerialization['teamSide'] as int)),
      position: jsonSerialization['position'] == null
          ? null
          : _i3.PlayerPosition.fromJson((jsonSerialization['position'] as int)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue matchId;

  _i1.UuidValue clubMemberId;

  _i2.MatchTeamSide teamSide;

  _i3.PlayerPosition? position;

  /// Returns a shallow copy of this [MatchParticipant]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MatchParticipant copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? matchId,
    _i1.UuidValue? clubMemberId,
    _i2.MatchTeamSide? teamSide,
    _i3.PlayerPosition? position,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      'matchId': matchId.toJson(),
      'clubMemberId': clubMemberId.toJson(),
      'teamSide': teamSide.toJson(),
      if (position != null) 'position': position?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MatchParticipantImpl extends MatchParticipant {
  _MatchParticipantImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue matchId,
    required _i1.UuidValue clubMemberId,
    required _i2.MatchTeamSide teamSide,
    _i3.PlayerPosition? position,
  }) : super._(
          id: id,
          matchId: matchId,
          clubMemberId: clubMemberId,
          teamSide: teamSide,
          position: position,
        );

  /// Returns a shallow copy of this [MatchParticipant]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MatchParticipant copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? matchId,
    _i1.UuidValue? clubMemberId,
    _i2.MatchTeamSide? teamSide,
    Object? position = _Undefined,
  }) {
    return MatchParticipant(
      id: id is _i1.UuidValue? ? id : this.id,
      matchId: matchId ?? this.matchId,
      clubMemberId: clubMemberId ?? this.clubMemberId,
      teamSide: teamSide ?? this.teamSide,
      position: position is _i3.PlayerPosition? ? position : this.position,
    );
  }
}
