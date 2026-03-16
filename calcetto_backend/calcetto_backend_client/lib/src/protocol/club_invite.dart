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

abstract class ClubInvite implements _i1.SerializableModel {
  ClubInvite._({
    this.id,
    required this.clubId,
    this.createdBy,
    required this.token,
    required this.expiresAt,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory ClubInvite({
    _i1.UuidValue? id,
    required _i1.UuidValue clubId,
    _i1.UuidValue? createdBy,
    required String token,
    required DateTime expiresAt,
    DateTime? createdAt,
  }) = _ClubInviteImpl;

  factory ClubInvite.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClubInvite(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      clubId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['clubId']),
      createdBy: jsonSerialization['createdBy'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['createdBy']),
      token: jsonSerialization['token'] as String,
      expiresAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue clubId;

  _i1.UuidValue? createdBy;

  String token;

  DateTime expiresAt;

  DateTime createdAt;

  /// Returns a shallow copy of this [ClubInvite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClubInvite copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? clubId,
    _i1.UuidValue? createdBy,
    String? token,
    DateTime? expiresAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      'clubId': clubId.toJson(),
      if (createdBy != null) 'createdBy': createdBy?.toJson(),
      'token': token,
      'expiresAt': expiresAt.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClubInviteImpl extends ClubInvite {
  _ClubInviteImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue clubId,
    _i1.UuidValue? createdBy,
    required String token,
    required DateTime expiresAt,
    DateTime? createdAt,
  }) : super._(
          id: id,
          clubId: clubId,
          createdBy: createdBy,
          token: token,
          expiresAt: expiresAt,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [ClubInvite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClubInvite copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? clubId,
    Object? createdBy = _Undefined,
    String? token,
    DateTime? expiresAt,
    DateTime? createdAt,
  }) {
    return ClubInvite(
      id: id is _i1.UuidValue? ? id : this.id,
      clubId: clubId ?? this.clubId,
      createdBy: createdBy is _i1.UuidValue? ? createdBy : this.createdBy,
      token: token ?? this.token,
      expiresAt: expiresAt ?? this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
