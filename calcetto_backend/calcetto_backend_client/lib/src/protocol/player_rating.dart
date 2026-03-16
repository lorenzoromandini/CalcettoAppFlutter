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

abstract class PlayerRating implements _i1.SerializableModel {
  PlayerRating._({
    this.id,
    required this.matchId,
    required this.clubMemberId,
    required this.rating,
    this.comment,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory PlayerRating({
    _i1.UuidValue? id,
    required _i1.UuidValue matchId,
    required _i1.UuidValue clubMemberId,
    required double rating,
    String? comment,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _PlayerRatingImpl;

  factory PlayerRating.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlayerRating(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      matchId:
          _i1.UuidValueJsonExtension.fromJson(jsonSerialization['matchId']),
      clubMemberId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['clubMemberId']),
      rating: (jsonSerialization['rating'] as num).toDouble(),
      comment: jsonSerialization['comment'] as String?,
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

  double rating;

  String? comment;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [PlayerRating]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PlayerRating copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? matchId,
    _i1.UuidValue? clubMemberId,
    double? rating,
    String? comment,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      'matchId': matchId.toJson(),
      'clubMemberId': clubMemberId.toJson(),
      'rating': rating,
      if (comment != null) 'comment': comment,
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

class _PlayerRatingImpl extends PlayerRating {
  _PlayerRatingImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue matchId,
    required _i1.UuidValue clubMemberId,
    required double rating,
    String? comment,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          matchId: matchId,
          clubMemberId: clubMemberId,
          rating: rating,
          comment: comment,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [PlayerRating]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PlayerRating copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? matchId,
    _i1.UuidValue? clubMemberId,
    double? rating,
    Object? comment = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PlayerRating(
      id: id is _i1.UuidValue? ? id : this.id,
      matchId: matchId ?? this.matchId,
      clubMemberId: clubMemberId ?? this.clubMemberId,
      rating: rating ?? this.rating,
      comment: comment is String? ? comment : this.comment,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
