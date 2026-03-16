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

abstract class Goal implements _i1.SerializableModel {
  Goal._({
    this.id,
    required this.matchId,
    required this.scorerId,
    this.assisterId,
    required this.isOwnGoal,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Goal({
    _i1.UuidValue? id,
    required _i1.UuidValue matchId,
    required _i1.UuidValue scorerId,
    _i1.UuidValue? assisterId,
    required bool isOwnGoal,
    DateTime? createdAt,
  }) = _GoalImpl;

  factory Goal.fromJson(Map<String, dynamic> jsonSerialization) {
    return Goal(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      matchId:
          _i1.UuidValueJsonExtension.fromJson(jsonSerialization['matchId']),
      scorerId:
          _i1.UuidValueJsonExtension.fromJson(jsonSerialization['scorerId']),
      assisterId: jsonSerialization['assisterId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['assisterId']),
      isOwnGoal: jsonSerialization['isOwnGoal'] as bool,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue matchId;

  _i1.UuidValue scorerId;

  _i1.UuidValue? assisterId;

  bool isOwnGoal;

  DateTime createdAt;

  /// Returns a shallow copy of this [Goal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Goal copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? matchId,
    _i1.UuidValue? scorerId,
    _i1.UuidValue? assisterId,
    bool? isOwnGoal,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      'matchId': matchId.toJson(),
      'scorerId': scorerId.toJson(),
      if (assisterId != null) 'assisterId': assisterId?.toJson(),
      'isOwnGoal': isOwnGoal,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GoalImpl extends Goal {
  _GoalImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue matchId,
    required _i1.UuidValue scorerId,
    _i1.UuidValue? assisterId,
    required bool isOwnGoal,
    DateTime? createdAt,
  }) : super._(
          id: id,
          matchId: matchId,
          scorerId: scorerId,
          assisterId: assisterId,
          isOwnGoal: isOwnGoal,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [Goal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Goal copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? matchId,
    _i1.UuidValue? scorerId,
    Object? assisterId = _Undefined,
    bool? isOwnGoal,
    DateTime? createdAt,
  }) {
    return Goal(
      id: id is _i1.UuidValue? ? id : this.id,
      matchId: matchId ?? this.matchId,
      scorerId: scorerId ?? this.scorerId,
      assisterId: assisterId is _i1.UuidValue? ? assisterId : this.assisterId,
      isOwnGoal: isOwnGoal ?? this.isOwnGoal,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
