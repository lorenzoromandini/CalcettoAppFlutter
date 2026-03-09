// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClubImpl _$$ClubImplFromJson(Map<String, dynamic> json) => _$ClubImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      logoUrl: json['logoUrl'] as String?,
      memberCount: (json['memberCount'] as num).toInt(),
      userRole: $enumDecode(_$ClubRoleEnumMap, json['userRole']),
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ClubImplToJson(_$ClubImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logoUrl': instance.logoUrl,
      'memberCount': instance.memberCount,
      'userRole': _$ClubRoleEnumMap[instance.userRole]!,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$ClubRoleEnumMap = {
  ClubRole.owner: 'owner',
  ClubRole.manager: 'manager',
  ClubRole.member: 'member',
};
