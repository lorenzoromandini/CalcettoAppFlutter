// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'club_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClubMember _$ClubMemberFromJson(Map<String, dynamic> json) {
  return _ClubMember.fromJson(json);
}

/// @nodoc
mixin _$ClubMember {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get clubId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get avatarUrl =>
      throw _privateConstructorUsedError; // Player position on the field
  PlayerPosition get primaryPosition => throw _privateConstructorUsedError;
  List<PlayerPosition> get secondaryPositions =>
      throw _privateConstructorUsedError; // Management privilege in the club
  ClubPrivilege get privilege =>
      throw _privateConstructorUsedError; // Membership details
  DateTime get joinedAt => throw _privateConstructorUsedError;
  int? get jerseyNumber => throw _privateConstructorUsedError;
  String? get symbol => throw _privateConstructorUsedError;
  String? get nationality =>
      throw _privateConstructorUsedError; // Statistics (Phase 4)
  ClubMemberStats? get stats => throw _privateConstructorUsedError;

  /// Serializes this ClubMember to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClubMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClubMemberCopyWith<ClubMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubMemberCopyWith<$Res> {
  factory $ClubMemberCopyWith(
          ClubMember value, $Res Function(ClubMember) then) =
      _$ClubMemberCopyWithImpl<$Res, ClubMember>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String clubId,
      String name,
      String? avatarUrl,
      PlayerPosition primaryPosition,
      List<PlayerPosition> secondaryPositions,
      ClubPrivilege privilege,
      DateTime joinedAt,
      int? jerseyNumber,
      String? symbol,
      String? nationality,
      ClubMemberStats? stats});

  $ClubMemberStatsCopyWith<$Res>? get stats;
}

/// @nodoc
class _$ClubMemberCopyWithImpl<$Res, $Val extends ClubMember>
    implements $ClubMemberCopyWith<$Res> {
  _$ClubMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClubMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? clubId = null,
    Object? name = null,
    Object? avatarUrl = freezed,
    Object? primaryPosition = null,
    Object? secondaryPositions = null,
    Object? privilege = null,
    Object? joinedAt = null,
    Object? jerseyNumber = freezed,
    Object? symbol = freezed,
    Object? nationality = freezed,
    Object? stats = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      clubId: null == clubId
          ? _value.clubId
          : clubId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      primaryPosition: null == primaryPosition
          ? _value.primaryPosition
          : primaryPosition // ignore: cast_nullable_to_non_nullable
              as PlayerPosition,
      secondaryPositions: null == secondaryPositions
          ? _value.secondaryPositions
          : secondaryPositions // ignore: cast_nullable_to_non_nullable
              as List<PlayerPosition>,
      privilege: null == privilege
          ? _value.privilege
          : privilege // ignore: cast_nullable_to_non_nullable
              as ClubPrivilege,
      joinedAt: null == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      jerseyNumber: freezed == jerseyNumber
          ? _value.jerseyNumber
          : jerseyNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      symbol: freezed == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String?,
      nationality: freezed == nationality
          ? _value.nationality
          : nationality // ignore: cast_nullable_to_non_nullable
              as String?,
      stats: freezed == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as ClubMemberStats?,
    ) as $Val);
  }

  /// Create a copy of ClubMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ClubMemberStatsCopyWith<$Res>? get stats {
    if (_value.stats == null) {
      return null;
    }

    return $ClubMemberStatsCopyWith<$Res>(_value.stats!, (value) {
      return _then(_value.copyWith(stats: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ClubMemberImplCopyWith<$Res>
    implements $ClubMemberCopyWith<$Res> {
  factory _$$ClubMemberImplCopyWith(
          _$ClubMemberImpl value, $Res Function(_$ClubMemberImpl) then) =
      __$$ClubMemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String clubId,
      String name,
      String? avatarUrl,
      PlayerPosition primaryPosition,
      List<PlayerPosition> secondaryPositions,
      ClubPrivilege privilege,
      DateTime joinedAt,
      int? jerseyNumber,
      String? symbol,
      String? nationality,
      ClubMemberStats? stats});

  @override
  $ClubMemberStatsCopyWith<$Res>? get stats;
}

/// @nodoc
class __$$ClubMemberImplCopyWithImpl<$Res>
    extends _$ClubMemberCopyWithImpl<$Res, _$ClubMemberImpl>
    implements _$$ClubMemberImplCopyWith<$Res> {
  __$$ClubMemberImplCopyWithImpl(
      _$ClubMemberImpl _value, $Res Function(_$ClubMemberImpl) _then)
      : super(_value, _then);

  /// Create a copy of ClubMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? clubId = null,
    Object? name = null,
    Object? avatarUrl = freezed,
    Object? primaryPosition = null,
    Object? secondaryPositions = null,
    Object? privilege = null,
    Object? joinedAt = null,
    Object? jerseyNumber = freezed,
    Object? symbol = freezed,
    Object? nationality = freezed,
    Object? stats = freezed,
  }) {
    return _then(_$ClubMemberImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      clubId: null == clubId
          ? _value.clubId
          : clubId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      primaryPosition: null == primaryPosition
          ? _value.primaryPosition
          : primaryPosition // ignore: cast_nullable_to_non_nullable
              as PlayerPosition,
      secondaryPositions: null == secondaryPositions
          ? _value._secondaryPositions
          : secondaryPositions // ignore: cast_nullable_to_non_nullable
              as List<PlayerPosition>,
      privilege: null == privilege
          ? _value.privilege
          : privilege // ignore: cast_nullable_to_non_nullable
              as ClubPrivilege,
      joinedAt: null == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      jerseyNumber: freezed == jerseyNumber
          ? _value.jerseyNumber
          : jerseyNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      symbol: freezed == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String?,
      nationality: freezed == nationality
          ? _value.nationality
          : nationality // ignore: cast_nullable_to_non_nullable
              as String?,
      stats: freezed == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as ClubMemberStats?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClubMemberImpl implements _ClubMember {
  const _$ClubMemberImpl(
      {required this.id,
      required this.userId,
      required this.clubId,
      required this.name,
      this.avatarUrl,
      required this.primaryPosition,
      final List<PlayerPosition> secondaryPositions = const [],
      required this.privilege,
      required this.joinedAt,
      this.jerseyNumber,
      this.symbol,
      this.nationality,
      this.stats})
      : _secondaryPositions = secondaryPositions;

  factory _$ClubMemberImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClubMemberImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String clubId;
  @override
  final String name;
  @override
  final String? avatarUrl;
// Player position on the field
  @override
  final PlayerPosition primaryPosition;
  final List<PlayerPosition> _secondaryPositions;
  @override
  @JsonKey()
  List<PlayerPosition> get secondaryPositions {
    if (_secondaryPositions is EqualUnmodifiableListView)
      return _secondaryPositions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_secondaryPositions);
  }

// Management privilege in the club
  @override
  final ClubPrivilege privilege;
// Membership details
  @override
  final DateTime joinedAt;
  @override
  final int? jerseyNumber;
  @override
  final String? symbol;
  @override
  final String? nationality;
// Statistics (Phase 4)
  @override
  final ClubMemberStats? stats;

  @override
  String toString() {
    return 'ClubMember(id: $id, userId: $userId, clubId: $clubId, name: $name, avatarUrl: $avatarUrl, primaryPosition: $primaryPosition, secondaryPositions: $secondaryPositions, privilege: $privilege, joinedAt: $joinedAt, jerseyNumber: $jerseyNumber, symbol: $symbol, nationality: $nationality, stats: $stats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClubMemberImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.clubId, clubId) || other.clubId == clubId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.primaryPosition, primaryPosition) ||
                other.primaryPosition == primaryPosition) &&
            const DeepCollectionEquality()
                .equals(other._secondaryPositions, _secondaryPositions) &&
            (identical(other.privilege, privilege) ||
                other.privilege == privilege) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt) &&
            (identical(other.jerseyNumber, jerseyNumber) ||
                other.jerseyNumber == jerseyNumber) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.nationality, nationality) ||
                other.nationality == nationality) &&
            (identical(other.stats, stats) || other.stats == stats));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      clubId,
      name,
      avatarUrl,
      primaryPosition,
      const DeepCollectionEquality().hash(_secondaryPositions),
      privilege,
      joinedAt,
      jerseyNumber,
      symbol,
      nationality,
      stats);

  /// Create a copy of ClubMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClubMemberImplCopyWith<_$ClubMemberImpl> get copyWith =>
      __$$ClubMemberImplCopyWithImpl<_$ClubMemberImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClubMemberImplToJson(
      this,
    );
  }
}

abstract class _ClubMember implements ClubMember {
  const factory _ClubMember(
      {required final String id,
      required final String userId,
      required final String clubId,
      required final String name,
      final String? avatarUrl,
      required final PlayerPosition primaryPosition,
      final List<PlayerPosition> secondaryPositions,
      required final ClubPrivilege privilege,
      required final DateTime joinedAt,
      final int? jerseyNumber,
      final String? symbol,
      final String? nationality,
      final ClubMemberStats? stats}) = _$ClubMemberImpl;

  factory _ClubMember.fromJson(Map<String, dynamic> json) =
      _$ClubMemberImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get clubId;
  @override
  String get name;
  @override
  String? get avatarUrl; // Player position on the field
  @override
  PlayerPosition get primaryPosition;
  @override
  List<PlayerPosition>
      get secondaryPositions; // Management privilege in the club
  @override
  ClubPrivilege get privilege; // Membership details
  @override
  DateTime get joinedAt;
  @override
  int? get jerseyNumber;
  @override
  String? get symbol;
  @override
  String? get nationality; // Statistics (Phase 4)
  @override
  ClubMemberStats? get stats;

  /// Create a copy of ClubMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClubMemberImplCopyWith<_$ClubMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClubMemberStats _$ClubMemberStatsFromJson(Map<String, dynamic> json) {
  return _ClubMemberStats.fromJson(json);
}

/// @nodoc
mixin _$ClubMemberStats {
  int get matchesPlayed => throw _privateConstructorUsedError;
  int get goals => throw _privateConstructorUsedError;
  int get assists => throw _privateConstructorUsedError;
  double? get averageRating => throw _privateConstructorUsedError;

  /// Serializes this ClubMemberStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClubMemberStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClubMemberStatsCopyWith<ClubMemberStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubMemberStatsCopyWith<$Res> {
  factory $ClubMemberStatsCopyWith(
          ClubMemberStats value, $Res Function(ClubMemberStats) then) =
      _$ClubMemberStatsCopyWithImpl<$Res, ClubMemberStats>;
  @useResult
  $Res call({int matchesPlayed, int goals, int assists, double? averageRating});
}

/// @nodoc
class _$ClubMemberStatsCopyWithImpl<$Res, $Val extends ClubMemberStats>
    implements $ClubMemberStatsCopyWith<$Res> {
  _$ClubMemberStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClubMemberStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matchesPlayed = null,
    Object? goals = null,
    Object? assists = null,
    Object? averageRating = freezed,
  }) {
    return _then(_value.copyWith(
      matchesPlayed: null == matchesPlayed
          ? _value.matchesPlayed
          : matchesPlayed // ignore: cast_nullable_to_non_nullable
              as int,
      goals: null == goals
          ? _value.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as int,
      assists: null == assists
          ? _value.assists
          : assists // ignore: cast_nullable_to_non_nullable
              as int,
      averageRating: freezed == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClubMemberStatsImplCopyWith<$Res>
    implements $ClubMemberStatsCopyWith<$Res> {
  factory _$$ClubMemberStatsImplCopyWith(_$ClubMemberStatsImpl value,
          $Res Function(_$ClubMemberStatsImpl) then) =
      __$$ClubMemberStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int matchesPlayed, int goals, int assists, double? averageRating});
}

/// @nodoc
class __$$ClubMemberStatsImplCopyWithImpl<$Res>
    extends _$ClubMemberStatsCopyWithImpl<$Res, _$ClubMemberStatsImpl>
    implements _$$ClubMemberStatsImplCopyWith<$Res> {
  __$$ClubMemberStatsImplCopyWithImpl(
      _$ClubMemberStatsImpl _value, $Res Function(_$ClubMemberStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ClubMemberStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matchesPlayed = null,
    Object? goals = null,
    Object? assists = null,
    Object? averageRating = freezed,
  }) {
    return _then(_$ClubMemberStatsImpl(
      matchesPlayed: null == matchesPlayed
          ? _value.matchesPlayed
          : matchesPlayed // ignore: cast_nullable_to_non_nullable
              as int,
      goals: null == goals
          ? _value.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as int,
      assists: null == assists
          ? _value.assists
          : assists // ignore: cast_nullable_to_non_nullable
              as int,
      averageRating: freezed == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClubMemberStatsImpl implements _ClubMemberStats {
  const _$ClubMemberStatsImpl(
      {this.matchesPlayed = 0,
      this.goals = 0,
      this.assists = 0,
      this.averageRating});

  factory _$ClubMemberStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClubMemberStatsImplFromJson(json);

  @override
  @JsonKey()
  final int matchesPlayed;
  @override
  @JsonKey()
  final int goals;
  @override
  @JsonKey()
  final int assists;
  @override
  final double? averageRating;

  @override
  String toString() {
    return 'ClubMemberStats(matchesPlayed: $matchesPlayed, goals: $goals, assists: $assists, averageRating: $averageRating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClubMemberStatsImpl &&
            (identical(other.matchesPlayed, matchesPlayed) ||
                other.matchesPlayed == matchesPlayed) &&
            (identical(other.goals, goals) || other.goals == goals) &&
            (identical(other.assists, assists) || other.assists == assists) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, matchesPlayed, goals, assists, averageRating);

  /// Create a copy of ClubMemberStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClubMemberStatsImplCopyWith<_$ClubMemberStatsImpl> get copyWith =>
      __$$ClubMemberStatsImplCopyWithImpl<_$ClubMemberStatsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClubMemberStatsImplToJson(
      this,
    );
  }
}

abstract class _ClubMemberStats implements ClubMemberStats {
  const factory _ClubMemberStats(
      {final int matchesPlayed,
      final int goals,
      final int assists,
      final double? averageRating}) = _$ClubMemberStatsImpl;

  factory _ClubMemberStats.fromJson(Map<String, dynamic> json) =
      _$ClubMemberStatsImpl.fromJson;

  @override
  int get matchesPlayed;
  @override
  int get goals;
  @override
  int get assists;
  @override
  double? get averageRating;

  /// Create a copy of ClubMemberStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClubMemberStatsImplCopyWith<_$ClubMemberStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
