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
import 'match_mode.dart' as _i2;
import 'match_status.dart' as _i3;

abstract class Match implements _i1.SerializableModel {
  Match._({
    this.id,
    required this.clubId,
    required this.scheduledAt,
    this.location,
    required this.mode,
    required this.status,
    required this.homeScore,
    required this.awayScore,
    this.notes,
    this.createdBy,
    this.scoreFinalizedBy,
    this.ratingsCompletedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory Match({
    _i1.UuidValue? id,
    required _i1.UuidValue clubId,
    required DateTime scheduledAt,
    String? location,
    required _i2.MatchMode mode,
    required _i3.MatchStatus status,
    required int homeScore,
    required int awayScore,
    String? notes,
    _i1.UuidValue? createdBy,
    _i1.UuidValue? scoreFinalizedBy,
    _i1.UuidValue? ratingsCompletedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _MatchImpl;

  factory Match.fromJson(Map<String, dynamic> jsonSerialization) {
    return Match(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      clubId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['clubId']),
      scheduledAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['scheduledAt']),
      location: jsonSerialization['location'] as String?,
      mode: _i2.MatchMode.fromJson((jsonSerialization['mode'] as int)),
      status: _i3.MatchStatus.fromJson((jsonSerialization['status'] as int)),
      homeScore: jsonSerialization['homeScore'] as int,
      awayScore: jsonSerialization['awayScore'] as int,
      notes: jsonSerialization['notes'] as String?,
      createdBy: jsonSerialization['createdBy'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['createdBy']),
      scoreFinalizedBy: jsonSerialization['scoreFinalizedBy'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['scoreFinalizedBy']),
      ratingsCompletedBy: jsonSerialization['ratingsCompletedBy'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['ratingsCompletedBy']),
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

  _i1.UuidValue clubId;

  DateTime scheduledAt;

  String? location;

  _i2.MatchMode mode;

  _i3.MatchStatus status;

  int homeScore;

  int awayScore;

  String? notes;

  _i1.UuidValue? createdBy;

  _i1.UuidValue? scoreFinalizedBy;

  _i1.UuidValue? ratingsCompletedBy;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Match]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Match copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? clubId,
    DateTime? scheduledAt,
    String? location,
    _i2.MatchMode? mode,
    _i3.MatchStatus? status,
    int? homeScore,
    int? awayScore,
    String? notes,
    _i1.UuidValue? createdBy,
    _i1.UuidValue? scoreFinalizedBy,
    _i1.UuidValue? ratingsCompletedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      'clubId': clubId.toJson(),
      'scheduledAt': scheduledAt.toJson(),
      if (location != null) 'location': location,
      'mode': mode.toJson(),
      'status': status.toJson(),
      'homeScore': homeScore,
      'awayScore': awayScore,
      if (notes != null) 'notes': notes,
      if (createdBy != null) 'createdBy': createdBy?.toJson(),
      if (scoreFinalizedBy != null)
        'scoreFinalizedBy': scoreFinalizedBy?.toJson(),
      if (ratingsCompletedBy != null)
        'ratingsCompletedBy': ratingsCompletedBy?.toJson(),
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

class _MatchImpl extends Match {
  _MatchImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue clubId,
    required DateTime scheduledAt,
    String? location,
    required _i2.MatchMode mode,
    required _i3.MatchStatus status,
    required int homeScore,
    required int awayScore,
    String? notes,
    _i1.UuidValue? createdBy,
    _i1.UuidValue? scoreFinalizedBy,
    _i1.UuidValue? ratingsCompletedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          clubId: clubId,
          scheduledAt: scheduledAt,
          location: location,
          mode: mode,
          status: status,
          homeScore: homeScore,
          awayScore: awayScore,
          notes: notes,
          createdBy: createdBy,
          scoreFinalizedBy: scoreFinalizedBy,
          ratingsCompletedBy: ratingsCompletedBy,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [Match]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Match copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? clubId,
    DateTime? scheduledAt,
    Object? location = _Undefined,
    _i2.MatchMode? mode,
    _i3.MatchStatus? status,
    int? homeScore,
    int? awayScore,
    Object? notes = _Undefined,
    Object? createdBy = _Undefined,
    Object? scoreFinalizedBy = _Undefined,
    Object? ratingsCompletedBy = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Match(
      id: id is _i1.UuidValue? ? id : this.id,
      clubId: clubId ?? this.clubId,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      location: location is String? ? location : this.location,
      mode: mode ?? this.mode,
      status: status ?? this.status,
      homeScore: homeScore ?? this.homeScore,
      awayScore: awayScore ?? this.awayScore,
      notes: notes is String? ? notes : this.notes,
      createdBy: createdBy is _i1.UuidValue? ? createdBy : this.createdBy,
      scoreFinalizedBy: scoreFinalizedBy is _i1.UuidValue?
          ? scoreFinalizedBy
          : this.scoreFinalizedBy,
      ratingsCompletedBy: ratingsCompletedBy is _i1.UuidValue?
          ? ratingsCompletedBy
          : this.ratingsCompletedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
