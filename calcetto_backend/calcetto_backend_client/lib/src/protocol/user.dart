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

abstract class UserInfo implements _i1.SerializableModel {
  UserInfo._({
    this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.nickname,
    this.imageUrl,
    required this.passwordHash,
    required this.passwordSalt,
    required this.createdAt,
    required this.updatedAt,
    this.lastLogin,
    this.deletedAt,
  });

  factory UserInfo({
    int? id,
    required String email,
    required String firstName,
    required String lastName,
    String? nickname,
    String? imageUrl,
    required String passwordHash,
    required String passwordSalt,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? lastLogin,
    DateTime? deletedAt,
  }) = _UserInfoImpl;

  factory UserInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserInfo(
      id: jsonSerialization['id'] as int?,
      email: jsonSerialization['email'] as String,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      nickname: jsonSerialization['nickname'] as String?,
      imageUrl: jsonSerialization['imageUrl'] as String?,
      passwordHash: jsonSerialization['passwordHash'] as String,
      passwordSalt: jsonSerialization['passwordSalt'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      lastLogin: jsonSerialization['lastLogin'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['lastLogin']),
      deletedAt: jsonSerialization['deletedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deletedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String email;

  String firstName;

  String lastName;

  String? nickname;

  String? imageUrl;

  String passwordHash;

  String passwordSalt;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? lastLogin;

  DateTime? deletedAt;

  /// Returns a shallow copy of this [UserInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserInfo copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? nickname,
    String? imageUrl,
    String? passwordHash,
    String? passwordSalt,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastLogin,
    DateTime? deletedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      if (nickname != null) 'nickname': nickname,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'passwordHash': passwordHash,
      'passwordSalt': passwordSalt,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (lastLogin != null) 'lastLogin': lastLogin?.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserInfoImpl extends UserInfo {
  _UserInfoImpl({
    int? id,
    required String email,
    required String firstName,
    required String lastName,
    String? nickname,
    String? imageUrl,
    required String passwordHash,
    required String passwordSalt,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? lastLogin,
    DateTime? deletedAt,
  }) : super._(
          id: id,
          email: email,
          firstName: firstName,
          lastName: lastName,
          nickname: nickname,
          imageUrl: imageUrl,
          passwordHash: passwordHash,
          passwordSalt: passwordSalt,
          createdAt: createdAt,
          updatedAt: updatedAt,
          lastLogin: lastLogin,
          deletedAt: deletedAt,
        );

  /// Returns a shallow copy of this [UserInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserInfo copyWith({
    Object? id = _Undefined,
    String? email,
    String? firstName,
    String? lastName,
    Object? nickname = _Undefined,
    Object? imageUrl = _Undefined,
    String? passwordHash,
    String? passwordSalt,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? lastLogin = _Undefined,
    Object? deletedAt = _Undefined,
  }) {
    return UserInfo(
      id: id is int? ? id : this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      nickname: nickname is String? ? nickname : this.nickname,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      passwordHash: passwordHash ?? this.passwordHash,
      passwordSalt: passwordSalt ?? this.passwordSalt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastLogin: lastLogin is DateTime? ? lastLogin : this.lastLogin,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
    );
  }
}
