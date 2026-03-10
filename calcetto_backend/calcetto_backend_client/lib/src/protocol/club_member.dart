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

abstract class ClubMember implements _i1.SerializableModel {
  ClubMember._({
    this.id,
    required this.clubId,
    required this.userId,
    required this.privileges,
    required this.joinedAt,
    this.deletedAt,
  });

  factory ClubMember({
    int? id,
    required int clubId,
    required int userId,
    required int privileges,
    required DateTime joinedAt,
    DateTime? deletedAt,
  }) = _ClubMemberImpl;

  factory ClubMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClubMember(
      id: jsonSerialization['id'] as int?,
      clubId: jsonSerialization['clubId'] as int,
      userId: jsonSerialization['userId'] as int,
      privileges: jsonSerialization['privileges'] as int,
      joinedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['joinedAt']),
      deletedAt: jsonSerialization['deletedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deletedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int clubId;

  int userId;

  int privileges;

  DateTime joinedAt;

  DateTime? deletedAt;

  /// Returns a shallow copy of this [ClubMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClubMember copyWith({
    int? id,
    int? clubId,
    int? userId,
    int? privileges,
    DateTime? joinedAt,
    DateTime? deletedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'clubId': clubId,
      'userId': userId,
      'privileges': privileges,
      'joinedAt': joinedAt.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClubMemberImpl extends ClubMember {
  _ClubMemberImpl({
    int? id,
    required int clubId,
    required int userId,
    required int privileges,
    required DateTime joinedAt,
    DateTime? deletedAt,
  }) : super._(
          id: id,
          clubId: clubId,
          userId: userId,
          privileges: privileges,
          joinedAt: joinedAt,
          deletedAt: deletedAt,
        );

  /// Returns a shallow copy of this [ClubMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClubMember copyWith({
    Object? id = _Undefined,
    int? clubId,
    int? userId,
    int? privileges,
    DateTime? joinedAt,
    Object? deletedAt = _Undefined,
  }) {
    return ClubMember(
      id: id is int? ? id : this.id,
      clubId: clubId ?? this.clubId,
      userId: userId ?? this.userId,
      privileges: privileges ?? this.privileges,
      joinedAt: joinedAt ?? this.joinedAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
    );
  }
}
