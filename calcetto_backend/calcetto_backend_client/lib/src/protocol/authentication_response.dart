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
import 'user.dart' as _i2;

abstract class AuthenticationResponse implements _i1.SerializableModel {
  AuthenticationResponse._({
    required this.success,
    this.token,
    this.error,
    this.user,
  });

  factory AuthenticationResponse({
    required bool success,
    String? token,
    String? error,
    _i2.UserInfo? user,
  }) = _AuthenticationResponseImpl;

  factory AuthenticationResponse.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return AuthenticationResponse(
      success: jsonSerialization['success'] as bool,
      token: jsonSerialization['token'] as String?,
      error: jsonSerialization['error'] as String?,
      user: jsonSerialization['user'] == null
          ? null
          : _i2.UserInfo.fromJson(
              (jsonSerialization['user'] as Map<String, dynamic>)),
    );
  }

  bool success;

  String? token;

  String? error;

  _i2.UserInfo? user;

  /// Returns a shallow copy of this [AuthenticationResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AuthenticationResponse copyWith({
    bool? success,
    String? token,
    String? error,
    _i2.UserInfo? user,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      if (token != null) 'token': token,
      if (error != null) 'error': error,
      if (user != null) 'user': user?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuthenticationResponseImpl extends AuthenticationResponse {
  _AuthenticationResponseImpl({
    required bool success,
    String? token,
    String? error,
    _i2.UserInfo? user,
  }) : super._(
          success: success,
          token: token,
          error: error,
          user: user,
        );

  /// Returns a shallow copy of this [AuthenticationResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AuthenticationResponse copyWith({
    bool? success,
    Object? token = _Undefined,
    Object? error = _Undefined,
    Object? user = _Undefined,
  }) {
    return AuthenticationResponse(
      success: success ?? this.success,
      token: token is String? ? token : this.token,
      error: error is String? ? error : this.error,
      user: user is _i2.UserInfo? ? user : this.user?.copyWith(),
    );
  }
}
