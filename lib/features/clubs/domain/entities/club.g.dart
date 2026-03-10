// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClubRoleAdapter extends TypeAdapter<ClubRole> {
  @override
  final int typeId = 1;

  @override
  ClubRole read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ClubRole.owner;
      case 1:
        return ClubRole.manager;
      case 2:
        return ClubRole.member;
      default:
        return ClubRole.owner;
    }
  }

  @override
  void write(BinaryWriter writer, ClubRole obj) {
    switch (obj) {
      case ClubRole.owner:
        writer.writeByte(0);
        break;
      case ClubRole.manager:
        writer.writeByte(1);
        break;
      case ClubRole.member:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClubRoleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
