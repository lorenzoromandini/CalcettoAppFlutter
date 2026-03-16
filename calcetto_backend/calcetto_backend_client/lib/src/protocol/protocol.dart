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
import 'auth_response.dart' as _i2;
import 'club.dart' as _i3;
import 'club_invite.dart' as _i4;
import 'club_member.dart' as _i5;
import 'club_privilege.dart' as _i6;
import 'goal.dart' as _i7;
import 'match.dart' as _i8;
import 'match_mode.dart' as _i9;
import 'match_participant.dart' as _i10;
import 'match_status.dart' as _i11;
import 'match_team_side.dart' as _i12;
import 'player_position.dart' as _i13;
import 'player_rating.dart' as _i14;
import 'user.dart' as _i15;
import 'package:calcetto_backend_client/src/protocol/goal.dart' as _i16;
import 'package:calcetto_backend_client/src/protocol/match.dart' as _i17;
import 'package:calcetto_backend_client/src/protocol/match_participant.dart'
    as _i18;
import 'package:calcetto_backend_client/src/protocol/player_rating.dart'
    as _i19;
export 'auth_response.dart';
export 'club.dart';
export 'club_invite.dart';
export 'club_member.dart';
export 'club_privilege.dart';
export 'goal.dart';
export 'match.dart';
export 'match_mode.dart';
export 'match_participant.dart';
export 'match_status.dart';
export 'match_team_side.dart';
export 'player_position.dart';
export 'player_rating.dart';
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
    if (t == _i2.AuthResponse) {
      return _i2.AuthResponse.fromJson(data) as T;
    }
    if (t == _i3.Club) {
      return _i3.Club.fromJson(data) as T;
    }
    if (t == _i4.ClubInvite) {
      return _i4.ClubInvite.fromJson(data) as T;
    }
    if (t == _i5.ClubMember) {
      return _i5.ClubMember.fromJson(data) as T;
    }
    if (t == _i6.ClubPrivilege) {
      return _i6.ClubPrivilege.fromJson(data) as T;
    }
    if (t == _i7.Goal) {
      return _i7.Goal.fromJson(data) as T;
    }
    if (t == _i8.Match) {
      return _i8.Match.fromJson(data) as T;
    }
    if (t == _i9.MatchMode) {
      return _i9.MatchMode.fromJson(data) as T;
    }
    if (t == _i10.MatchParticipant) {
      return _i10.MatchParticipant.fromJson(data) as T;
    }
    if (t == _i11.MatchStatus) {
      return _i11.MatchStatus.fromJson(data) as T;
    }
    if (t == _i12.MatchTeamSide) {
      return _i12.MatchTeamSide.fromJson(data) as T;
    }
    if (t == _i13.PlayerPosition) {
      return _i13.PlayerPosition.fromJson(data) as T;
    }
    if (t == _i14.PlayerRating) {
      return _i14.PlayerRating.fromJson(data) as T;
    }
    if (t == _i15.User) {
      return _i15.User.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.AuthResponse?>()) {
      return (data != null ? _i2.AuthResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.Club?>()) {
      return (data != null ? _i3.Club.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.ClubInvite?>()) {
      return (data != null ? _i4.ClubInvite.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.ClubMember?>()) {
      return (data != null ? _i5.ClubMember.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.ClubPrivilege?>()) {
      return (data != null ? _i6.ClubPrivilege.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Goal?>()) {
      return (data != null ? _i7.Goal.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.Match?>()) {
      return (data != null ? _i8.Match.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.MatchMode?>()) {
      return (data != null ? _i9.MatchMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.MatchParticipant?>()) {
      return (data != null ? _i10.MatchParticipant.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.MatchStatus?>()) {
      return (data != null ? _i11.MatchStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.MatchTeamSide?>()) {
      return (data != null ? _i12.MatchTeamSide.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.PlayerPosition?>()) {
      return (data != null ? _i13.PlayerPosition.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.PlayerRating?>()) {
      return (data != null ? _i14.PlayerRating.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.User?>()) {
      return (data != null ? _i15.User.fromJson(data) : null) as T;
    }
    if (t == List<_i13.PlayerPosition>) {
      return (data as List)
          .map((e) => deserialize<_i13.PlayerPosition>(e))
          .toList() as T;
    }
    if (t == Map<String, dynamic>) {
      return (data as Map).map((k, v) =>
          MapEntry(deserialize<String>(k), deserialize<dynamic>(v))) as T;
    }
    if (t == List<Map<String, dynamic>>) {
      return (data as List)
          .map((e) => deserialize<Map<String, dynamic>>(e))
          .toList() as T;
    }
    if (t == _i1.getType<Map<String, dynamic>?>()) {
      return (data != null
          ? (data as Map).map((k, v) =>
              MapEntry(deserialize<String>(k), deserialize<dynamic>(v)))
          : null) as T;
    }
    if (t == List<_i16.Goal>) {
      return (data as List).map((e) => deserialize<_i16.Goal>(e)).toList() as T;
    }
    if (t == List<_i17.Match>) {
      return (data as List).map((e) => deserialize<_i17.Match>(e)).toList()
          as T;
    }
    if (t == List<_i18.MatchParticipant>) {
      return (data as List)
          .map((e) => deserialize<_i18.MatchParticipant>(e))
          .toList() as T;
    }
    if (t == List<_i19.PlayerRating>) {
      return (data as List)
          .map((e) => deserialize<_i19.PlayerRating>(e))
          .toList() as T;
    }
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.AuthResponse) {
      return 'AuthResponse';
    }
    if (data is _i3.Club) {
      return 'Club';
    }
    if (data is _i4.ClubInvite) {
      return 'ClubInvite';
    }
    if (data is _i5.ClubMember) {
      return 'ClubMember';
    }
    if (data is _i6.ClubPrivilege) {
      return 'ClubPrivilege';
    }
    if (data is _i7.Goal) {
      return 'Goal';
    }
    if (data is _i8.Match) {
      return 'Match';
    }
    if (data is _i9.MatchMode) {
      return 'MatchMode';
    }
    if (data is _i10.MatchParticipant) {
      return 'MatchParticipant';
    }
    if (data is _i11.MatchStatus) {
      return 'MatchStatus';
    }
    if (data is _i12.MatchTeamSide) {
      return 'MatchTeamSide';
    }
    if (data is _i13.PlayerPosition) {
      return 'PlayerPosition';
    }
    if (data is _i14.PlayerRating) {
      return 'PlayerRating';
    }
    if (data is _i15.User) {
      return 'User';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AuthResponse') {
      return deserialize<_i2.AuthResponse>(data['data']);
    }
    if (dataClassName == 'Club') {
      return deserialize<_i3.Club>(data['data']);
    }
    if (dataClassName == 'ClubInvite') {
      return deserialize<_i4.ClubInvite>(data['data']);
    }
    if (dataClassName == 'ClubMember') {
      return deserialize<_i5.ClubMember>(data['data']);
    }
    if (dataClassName == 'ClubPrivilege') {
      return deserialize<_i6.ClubPrivilege>(data['data']);
    }
    if (dataClassName == 'Goal') {
      return deserialize<_i7.Goal>(data['data']);
    }
    if (dataClassName == 'Match') {
      return deserialize<_i8.Match>(data['data']);
    }
    if (dataClassName == 'MatchMode') {
      return deserialize<_i9.MatchMode>(data['data']);
    }
    if (dataClassName == 'MatchParticipant') {
      return deserialize<_i10.MatchParticipant>(data['data']);
    }
    if (dataClassName == 'MatchStatus') {
      return deserialize<_i11.MatchStatus>(data['data']);
    }
    if (dataClassName == 'MatchTeamSide') {
      return deserialize<_i12.MatchTeamSide>(data['data']);
    }
    if (dataClassName == 'PlayerPosition') {
      return deserialize<_i13.PlayerPosition>(data['data']);
    }
    if (dataClassName == 'PlayerRating') {
      return deserialize<_i14.PlayerRating>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i15.User>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}
