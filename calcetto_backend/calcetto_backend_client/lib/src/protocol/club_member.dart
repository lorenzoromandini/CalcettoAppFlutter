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
import 'player_position.dart' as _i2;
import 'club_privilege.dart' as _i3;

abstract class ClubMember implements _i1.SerializableModel {
  ClubMember._({
    this.id,
    required this.clubId,
    required this.userId,
    this.jerseyNumber,
    this.symbol,
    this.nationality,
    required this.primaryRole,
    required this.secondaryRoles,
    required this.privilege,
    DateTime? joinedAt,
    this.leftAt,
  }) : joinedAt = joinedAt ?? DateTime.now();

  factory ClubMember({
    _i1.UuidValue? id,
    required _i1.UuidValue clubId,
    required _i1.UuidValue userId,
    int? jerseyNumber,
    String? symbol,
    String? nationality,
    required _i2.PlayerPosition primaryRole,
    required List<_i2.PlayerPosition> secondaryRoles,
    required _i3.ClubPrivilege privilege,
    DateTime? joinedAt,
    DateTime? leftAt,
  }) = _ClubMemberImpl;

  factory ClubMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClubMember(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      clubId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['clubId']),
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      jerseyNumber: jsonSerialization['jerseyNumber'] as int?,
      symbol: jsonSerialization['symbol'] as String?,
      nationality: jsonSerialization['nationality'] as String?,
      primaryRole: _i2.PlayerPosition.fromJson(
          (jsonSerialization['primaryRole'] as int)),
      secondaryRoles: (jsonSerialization['secondaryRoles'] as List)
          .map((e) => _i2.PlayerPosition.fromJson((e as int)))
          .toList(),
      privilege:
          _i3.ClubPrivilege.fromJson((jsonSerialization['privilege'] as int)),
      joinedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['joinedAt']),
      leftAt: jsonSerialization['leftAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['leftAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue clubId;

  _i1.UuidValue userId;

  int? jerseyNumber;

  String? symbol;

  String? nationality;

  _i2.PlayerPosition primaryRole;

  List<_i2.PlayerPosition> secondaryRoles;

  _i3.ClubPrivilege privilege;

  DateTime joinedAt;

  DateTime? leftAt;

  /// Returns a shallow copy of this [ClubMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClubMember copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? clubId,
    _i1.UuidValue? userId,
    int? jerseyNumber,
    String? symbol,
    String? nationality,
    _i2.PlayerPosition? primaryRole,
    List<_i2.PlayerPosition>? secondaryRoles,
    _i3.ClubPrivilege? privilege,
    DateTime? joinedAt,
    DateTime? leftAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      'clubId': clubId.toJson(),
      'userId': userId.toJson(),
      if (jerseyNumber != null) 'jerseyNumber': jerseyNumber,
      if (symbol != null) 'symbol': symbol,
      if (nationality != null) 'nationality': nationality,
      'primaryRole': primaryRole.toJson(),
      'secondaryRoles': secondaryRoles.toJson(valueToJson: (v) => v.toJson()),
      'privilege': privilege.toJson(),
      'joinedAt': joinedAt.toJson(),
      if (leftAt != null) 'leftAt': leftAt?.toJson(),
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
    _i1.UuidValue? id,
    required _i1.UuidValue clubId,
    required _i1.UuidValue userId,
    int? jerseyNumber,
    String? symbol,
    String? nationality,
    required _i2.PlayerPosition primaryRole,
    required List<_i2.PlayerPosition> secondaryRoles,
    required _i3.ClubPrivilege privilege,
    DateTime? joinedAt,
    DateTime? leftAt,
  }) : super._(
          id: id,
          clubId: clubId,
          userId: userId,
          jerseyNumber: jerseyNumber,
          symbol: symbol,
          nationality: nationality,
          primaryRole: primaryRole,
          secondaryRoles: secondaryRoles,
          privilege: privilege,
          joinedAt: joinedAt,
          leftAt: leftAt,
        );

  /// Returns a shallow copy of this [ClubMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClubMember copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? clubId,
    _i1.UuidValue? userId,
    Object? jerseyNumber = _Undefined,
    Object? symbol = _Undefined,
    Object? nationality = _Undefined,
    _i2.PlayerPosition? primaryRole,
    List<_i2.PlayerPosition>? secondaryRoles,
    _i3.ClubPrivilege? privilege,
    DateTime? joinedAt,
    Object? leftAt = _Undefined,
  }) {
    return ClubMember(
      id: id is _i1.UuidValue? ? id : this.id,
      clubId: clubId ?? this.clubId,
      userId: userId ?? this.userId,
      jerseyNumber: jerseyNumber is int? ? jerseyNumber : this.jerseyNumber,
      symbol: symbol is String? ? symbol : this.symbol,
      nationality: nationality is String? ? nationality : this.nationality,
      primaryRole: primaryRole ?? this.primaryRole,
      secondaryRoles:
          secondaryRoles ?? this.secondaryRoles.map((e0) => e0).toList(),
      privilege: privilege ?? this.privilege,
      joinedAt: joinedAt ?? this.joinedAt,
      leftAt: leftAt is DateTime? ? leftAt : this.leftAt,
    );
  }
}
