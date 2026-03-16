// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MemberImpl _$$MemberImplFromJson(Map<String, dynamic> json) => _$MemberImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      privilege: $enumDecode(_$ClubPrivilegeEnumMap, json['privilege']),
      joinedAt: DateTime.parse(json['joinedAt'] as String),
      stats: json['stats'] == null
          ? null
          : MemberStats.fromJson(json['stats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$MemberImplToJson(_$MemberImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
      'privilege': _$ClubPrivilegeEnumMap[instance.privilege]!,
      'joinedAt': instance.joinedAt.toIso8601String(),
      'stats': instance.stats,
    };

const _$ClubPrivilegeEnumMap = {
  ClubPrivilege.OWNER: 'OWNER',
  ClubPrivilege.MANAGER: 'MANAGER',
  ClubPrivilege.MEMBER: 'MEMBER',
};

_$MemberStatsImpl _$$MemberStatsImplFromJson(Map<String, dynamic> json) =>
    _$MemberStatsImpl(
      matchesPlayed: (json['matchesPlayed'] as num?)?.toInt() ?? 0,
      goals: (json['goals'] as num?)?.toInt() ?? 0,
      assists: (json['assists'] as num?)?.toInt() ?? 0,
      rating: (json['rating'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$MemberStatsImplToJson(_$MemberStatsImpl instance) =>
    <String, dynamic>{
      'matchesPlayed': instance.matchesPlayed,
      'goals': instance.goals,
      'assists': instance.assists,
      'rating': instance.rating,
    };
