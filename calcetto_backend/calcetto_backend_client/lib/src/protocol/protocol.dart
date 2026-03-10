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
import 'authentication_response.dart' as _i2;
import 'club.dart' as _i3;
import 'club_member.dart' as _i4;
import 'club_privilege.dart' as _i5;
import 'greeting.dart' as _i6;
import 'user.dart' as _i7;
import 'package:calcetto_backend_client/src/protocol/club.dart' as _i8;
export 'authentication_response.dart';
export 'club.dart';
export 'club_member.dart';
export 'club_privilege.dart';
export 'greeting.dart';
export 'user.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i2.AuthenticationResponse) {
      return _i2.AuthenticationResponse.fromJson(data) as T;
    }
    if (t == _i3.Club) {
      return _i3.Club.fromJson(data) as T;
    }
    if (t == _i4.ClubMember) {
      return _i4.ClubMember.fromJson(data) as T;
    }
    if (t == _i5.ClubPrivilege) {
      return _i5.ClubPrivilege.fromJson(data) as T;
    }
    if (t == _i6.Greeting) {
      return _i6.Greeting.fromJson(data) as T;
    }
    if (t == _i7.UserInfo) {
      return _i7.UserInfo.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.AuthenticationResponse?>()) {
      return (data != null ? _i2.AuthenticationResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i3.Club?>()) {
      return (data != null ? _i3.Club.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.ClubMember?>()) {
      return (data != null ? _i4.ClubMember.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.ClubPrivilege?>()) {
      return (data != null ? _i5.ClubPrivilege.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Greeting?>()) {
      return (data != null ? _i6.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.UserInfo?>()) {
      return (data != null ? _i7.UserInfo.fromJson(data) : null) as T;
    }
    if (t == List<_i8.Club>) {
      return (data as List).map((e) => deserialize<_i8.Club>(e)).toList() as T;
    }
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.AuthenticationResponse) {
      return 'AuthenticationResponse';
    }
    if (data is _i3.Club) {
      return 'Club';
    }
    if (data is _i4.ClubMember) {
      return 'ClubMember';
    }
    if (data is _i5.ClubPrivilege) {
      return 'ClubPrivilege';
    }
    if (data is _i6.Greeting) {
      return 'Greeting';
    }
    if (data is _i7.UserInfo) {
      return 'UserInfo';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AuthenticationResponse') {
      return deserialize<_i2.AuthenticationResponse>(data['data']);
    }
    if (dataClassName == 'Club') {
      return deserialize<_i3.Club>(data['data']);
    }
    if (dataClassName == 'ClubMember') {
      return deserialize<_i4.ClubMember>(data['data']);
    }
    if (dataClassName == 'ClubPrivilege') {
      return deserialize<_i5.ClubPrivilege>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i6.Greeting>(data['data']);
    }
    if (dataClassName == 'UserInfo') {
      return deserialize<_i7.UserInfo>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}
