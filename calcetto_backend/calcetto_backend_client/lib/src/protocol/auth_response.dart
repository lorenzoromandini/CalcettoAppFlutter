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

abstract class AuthResponse implements _i1.SerializableModel {
  AuthResponse._({
    required this.success,
    this.error,
    this.token,
    this.userId,
  });

  factory AuthResponse({
    required bool success,
    String? error,
    String? token,
    _i1.UuidValue? userId,
  }) = _AuthResponseImpl;

  factory AuthResponse.fromJson(Map<String, dynamic> jsonSerialization) {
    return AuthResponse(
      success: jsonSerialization['success'] as bool,
      error: jsonSerialization['error'] as String?,
      token: jsonSerialization['token'] as String?,
      userId: jsonSerialization['userId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
    );
  }

  bool success;

  String? error;

  String? token;

  _i1.UuidValue? userId;

  /// Returns a shallow copy of this [AuthResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AuthResponse copyWith({
    bool? success,
    String? error,
    String? token,
    _i1.UuidValue? userId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      if (error != null) 'error': error,
      if (token != null) 'token': token,
      if (userId != null) 'userId': userId?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuthResponseImpl extends AuthResponse {
  _AuthResponseImpl({
    required bool success,
    String? error,
    String? token,
    _i1.UuidValue? userId,
  }) : super._(
          success: success,
          error: error,
          token: token,
          userId: userId,
        );

  /// Returns a shallow copy of this [AuthResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AuthResponse copyWith({
    bool? success,
    Object? error = _Undefined,
    Object? token = _Undefined,
    Object? userId = _Undefined,
  }) {
    return AuthResponse(
      success: success ?? this.success,
      error: error is String? ? error : this.error,
      token: token is String? ? token : this.token,
      userId: userId is _i1.UuidValue? ? userId : this.userId,
    );
  }
}
