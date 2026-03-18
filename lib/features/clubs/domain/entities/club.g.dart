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
      userPrivilege: $enumDecode(_$ClubPrivilegeEnumMap, json['userPrivilege']),
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
    );

Map<String, dynamic> _$$ClubImplToJson(_$ClubImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logoUrl': instance.logoUrl,
      'memberCount': instance.memberCount,
      'userPrivilege': _$ClubPrivilegeEnumMap[instance.userPrivilege]!,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };

const _$ClubPrivilegeEnumMap = {
  ClubPrivilege.OWNER: 'OWNER',
  ClubPrivilege.MANAGER: 'MANAGER',
  ClubPrivilege.MEMBER: 'MEMBER',
};
