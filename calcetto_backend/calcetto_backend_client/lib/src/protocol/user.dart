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

abstract class User implements _i1.SerializableModel {
  User._({
    this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.nickname,
    this.imageUrl,
    required this.password,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.lastLogin,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory User({
    _i1.UuidValue? id,
    required String email,
    required String firstName,
    required String lastName,
    String? nickname,
    String? imageUrl,
    required String password,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastLogin,
  }) = _UserImpl;

  factory User.fromJson(Map<String, dynamic> jsonSerialization) {
    return User(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      email: jsonSerialization['email'] as String,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      nickname: jsonSerialization['nickname'] as String?,
      imageUrl: jsonSerialization['imageUrl'] as String?,
      password: jsonSerialization['password'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      lastLogin: jsonSerialization['lastLogin'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['lastLogin']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  String email;

  String firstName;

  String lastName;

  String? nickname;

  String? imageUrl;

  String password;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? lastLogin;

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  User copyWith({
    _i1.UuidValue? id,
    String? email,
    String? firstName,
    String? lastName,
    String? nickname,
    String? imageUrl,
    String? password,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastLogin,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      if (nickname != null) 'nickname': nickname,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'password': password,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (lastLogin != null) 'lastLogin': lastLogin?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserImpl extends User {
  _UserImpl({
    _i1.UuidValue? id,
    required String email,
    required String firstName,
    required String lastName,
    String? nickname,
    String? imageUrl,
    required String password,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastLogin,
  }) : super._(
          id: id,
          email: email,
          firstName: firstName,
          lastName: lastName,
          nickname: nickname,
          imageUrl: imageUrl,
          password: password,
          createdAt: createdAt,
          updatedAt: updatedAt,
          lastLogin: lastLogin,
        );

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  User copyWith({
    Object? id = _Undefined,
    String? email,
    String? firstName,
    String? lastName,
    Object? nickname = _Undefined,
    Object? imageUrl = _Undefined,
    String? password,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? lastLogin = _Undefined,
  }) {
    return User(
      id: id is _i1.UuidValue? ? id : this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      nickname: nickname is String? ? nickname : this.nickname,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastLogin: lastLogin is DateTime? ? lastLogin : this.lastLogin,
    );
  }
}
