// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClubMemberImpl _$$ClubMemberImplFromJson(Map<String, dynamic> json) =>
    _$ClubMemberImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      clubId: json['clubId'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      primaryPosition:
          $enumDecode(_$PlayerPositionEnumMap, json['primaryPosition']),
      secondaryPositions: (json['secondaryPositions'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$PlayerPositionEnumMap, e))
              .toList() ??
          const [],
      privilege: $enumDecode(_$ClubPrivilegeEnumMap, json['privilege']),
      joinedAt: DateTime.parse(json['joinedAt'] as String),
      jerseyNumber: (json['jerseyNumber'] as num?)?.toInt(),
      symbol: json['symbol'] as String?,
      nationality: json['nationality'] as String?,
      stats: json['stats'] == null
          ? null
          : ClubMemberStats.fromJson(json['stats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ClubMemberImplToJson(_$ClubMemberImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'clubId': instance.clubId,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
      'primaryPosition': _$PlayerPositionEnumMap[instance.primaryPosition]!,
      'secondaryPositions': instance.secondaryPositions
          .map((e) => _$PlayerPositionEnumMap[e]!)
          .toList(),
      'privilege': _$ClubPrivilegeEnumMap[instance.privilege]!,
      'joinedAt': instance.joinedAt.toIso8601String(),
      'jerseyNumber': instance.jerseyNumber,
      'symbol': instance.symbol,
      'nationality': instance.nationality,
      'stats': instance.stats,
    };

const _$PlayerPositionEnumMap = {
  PlayerPosition.GK: 'GK',
  PlayerPosition.DEF: 'DEF',
  PlayerPosition.MID: 'MID',
  PlayerPosition.ST: 'ST',
};

const _$ClubPrivilegeEnumMap = {
  ClubPrivilege.OWNER: 'OWNER',
  ClubPrivilege.MANAGER: 'MANAGER',
  ClubPrivilege.MEMBER: 'MEMBER',
};

_$ClubMemberStatsImpl _$$ClubMemberStatsImplFromJson(
        Map<String, dynamic> json) =>
    _$ClubMemberStatsImpl(
      matchesPlayed: (json['matchesPlayed'] as num?)?.toInt() ?? 0,
      goals: (json['goals'] as num?)?.toInt() ?? 0,
      assists: (json['assists'] as num?)?.toInt() ?? 0,
      averageRating: (json['averageRating'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$ClubMemberStatsImplToJson(
        _$ClubMemberStatsImpl instance) =>
    <String, dynamic>{
      'matchesPlayed': instance.matchesPlayed,
      'goals': instance.goals,
      'assists': instance.assists,
      'averageRating': instance.averageRating,
    };
