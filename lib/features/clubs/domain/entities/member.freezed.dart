// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Member _$MemberFromJson(Map<String, dynamic> json) {
  return _Member.fromJson(json);
}

/// @nodoc
mixin _$Member {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  ClubPrivilege get privilege => throw _privateConstructorUsedError;
  DateTime get joinedAt => throw _privateConstructorUsedError;
  MemberStats? get stats => throw _privateConstructorUsedError;

  /// Serializes this Member to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Member
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MemberCopyWith<Member> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemberCopyWith<$Res> {
  factory $MemberCopyWith(Member value, $Res Function(Member) then) =
      _$MemberCopyWithImpl<$Res, Member>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? avatarUrl,
      ClubPrivilege privilege,
      DateTime joinedAt,
      MemberStats? stats});

  $MemberStatsCopyWith<$Res>? get stats;
}

/// @nodoc
class _$MemberCopyWithImpl<$Res, $Val extends Member>
    implements $MemberCopyWith<$Res> {
  _$MemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Member
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? avatarUrl = freezed,
    Object? privilege = null,
    Object? joinedAt = null,
    Object? stats = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      privilege: null == privilege
          ? _value.privilege
          : privilege // ignore: cast_nullable_to_non_nullable
              as ClubPrivilege,
      joinedAt: null == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      stats: freezed == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as MemberStats?,
    ) as $Val);
  }

  /// Create a copy of Member
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MemberStatsCopyWith<$Res>? get stats {
    if (_value.stats == null) {
      return null;
    }

    return $MemberStatsCopyWith<$Res>(_value.stats!, (value) {
      return _then(_value.copyWith(stats: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MemberImplCopyWith<$Res> implements $MemberCopyWith<$Res> {
  factory _$$MemberImplCopyWith(
          _$MemberImpl value, $Res Function(_$MemberImpl) then) =
      __$$MemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? avatarUrl,
      ClubPrivilege privilege,
      DateTime joinedAt,
      MemberStats? stats});

  @override
  $MemberStatsCopyWith<$Res>? get stats;
}

/// @nodoc
class __$$MemberImplCopyWithImpl<$Res>
    extends _$MemberCopyWithImpl<$Res, _$MemberImpl>
    implements _$$MemberImplCopyWith<$Res> {
  __$$MemberImplCopyWithImpl(
      _$MemberImpl _value, $Res Function(_$MemberImpl) _then)
      : super(_value, _then);

  /// Create a copy of Member
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? avatarUrl = freezed,
    Object? privilege = null,
    Object? joinedAt = null,
    Object? stats = freezed,
  }) {
    return _then(_$MemberImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      privilege: null == privilege
          ? _value.privilege
          : privilege // ignore: cast_nullable_to_non_nullable
              as ClubPrivilege,
      joinedAt: null == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      stats: freezed == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as MemberStats?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MemberImpl implements _Member {
  const _$MemberImpl(
      {required this.id,
      required this.name,
      this.avatarUrl,
      required this.privilege,
      required this.joinedAt,
      this.stats});

  factory _$MemberImpl.fromJson(Map<String, dynamic> json) =>
      _$$MemberImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? avatarUrl;
  @override
  final ClubPrivilege privilege;
  @override
  final DateTime joinedAt;
  @override
  final MemberStats? stats;

  @override
  String toString() {
    return 'Member(id: $id, name: $name, avatarUrl: $avatarUrl, privilege: $privilege, joinedAt: $joinedAt, stats: $stats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemberImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.privilege, privilege) ||
                other.privilege == privilege) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt) &&
            (identical(other.stats, stats) || other.stats == stats));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, avatarUrl, privilege, joinedAt, stats);

  /// Create a copy of Member
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MemberImplCopyWith<_$MemberImpl> get copyWith =>
      __$$MemberImplCopyWithImpl<_$MemberImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MemberImplToJson(
      this,
    );
  }
}

abstract class _Member implements Member {
  const factory _Member(
      {required final String id,
      required final String name,
      final String? avatarUrl,
      required final ClubPrivilege privilege,
      required final DateTime joinedAt,
      final MemberStats? stats}) = _$MemberImpl;

  factory _Member.fromJson(Map<String, dynamic> json) = _$MemberImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get avatarUrl;
  @override
  ClubPrivilege get privilege;
  @override
  DateTime get joinedAt;
  @override
  MemberStats? get stats;

  /// Create a copy of Member
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MemberImplCopyWith<_$MemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MemberStats _$MemberStatsFromJson(Map<String, dynamic> json) {
  return _MemberStats.fromJson(json);
}

/// @nodoc
mixin _$MemberStats {
  int get matchesPlayed => throw _privateConstructorUsedError;
  int get goals => throw _privateConstructorUsedError;
  int get assists => throw _privateConstructorUsedError;
  double? get rating => throw _privateConstructorUsedError;

  /// Serializes this MemberStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MemberStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MemberStatsCopyWith<MemberStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemberStatsCopyWith<$Res> {
  factory $MemberStatsCopyWith(
          MemberStats value, $Res Function(MemberStats) then) =
      _$MemberStatsCopyWithImpl<$Res, MemberStats>;
  @useResult
  $Res call({int matchesPlayed, int goals, int assists, double? rating});
}

/// @nodoc
class _$MemberStatsCopyWithImpl<$Res, $Val extends MemberStats>
    implements $MemberStatsCopyWith<$Res> {
  _$MemberStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MemberStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matchesPlayed = null,
    Object? goals = null,
    Object? assists = null,
    Object? rating = freezed,
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
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MemberStatsImplCopyWith<$Res>
    implements $MemberStatsCopyWith<$Res> {
  factory _$$MemberStatsImplCopyWith(
          _$MemberStatsImpl value, $Res Function(_$MemberStatsImpl) then) =
      __$$MemberStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int matchesPlayed, int goals, int assists, double? rating});
}

/// @nodoc
class __$$MemberStatsImplCopyWithImpl<$Res>
    extends _$MemberStatsCopyWithImpl<$Res, _$MemberStatsImpl>
    implements _$$MemberStatsImplCopyWith<$Res> {
  __$$MemberStatsImplCopyWithImpl(
      _$MemberStatsImpl _value, $Res Function(_$MemberStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of MemberStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matchesPlayed = null,
    Object? goals = null,
    Object? assists = null,
    Object? rating = freezed,
  }) {
    return _then(_$MemberStatsImpl(
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
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MemberStatsImpl implements _MemberStats {
  const _$MemberStatsImpl(
      {this.matchesPlayed = 0, this.goals = 0, this.assists = 0, this.rating});

  factory _$MemberStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$MemberStatsImplFromJson(json);

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
  final double? rating;

  @override
  String toString() {
    return 'MemberStats(matchesPlayed: $matchesPlayed, goals: $goals, assists: $assists, rating: $rating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemberStatsImpl &&
            (identical(other.matchesPlayed, matchesPlayed) ||
                other.matchesPlayed == matchesPlayed) &&
            (identical(other.goals, goals) || other.goals == goals) &&
            (identical(other.assists, assists) || other.assists == assists) &&
            (identical(other.rating, rating) || other.rating == rating));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, matchesPlayed, goals, assists, rating);

  /// Create a copy of MemberStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MemberStatsImplCopyWith<_$MemberStatsImpl> get copyWith =>
      __$$MemberStatsImplCopyWithImpl<_$MemberStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MemberStatsImplToJson(
      this,
    );
  }
}

abstract class _MemberStats implements MemberStats {
  const factory _MemberStats(
      {final int matchesPlayed,
      final int goals,
      final int assists,
      final double? rating}) = _$MemberStatsImpl;

  factory _MemberStats.fromJson(Map<String, dynamic> json) =
      _$MemberStatsImpl.fromJson;

  @override
  int get matchesPlayed;
  @override
  int get goals;
  @override
  int get assists;
  @override
  double? get rating;

  /// Create a copy of MemberStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MemberStatsImplCopyWith<_$MemberStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
