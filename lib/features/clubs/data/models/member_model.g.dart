// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MemberModelAdapter extends TypeAdapter<MemberModel> {
  @override
  final int typeId = 1;

  @override
  MemberModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MemberModel(
      id: fields[0] as String,
      name: fields[1] as String,
      avatarUrl: fields[2] as String?,
      role: fields[3] as ClubRole,
      joinedAt: fields[4] as DateTime,
      stats: fields[5] as MemberStats?,
      cachedAt: fields[6] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, MemberModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.avatarUrl)
      ..writeByte(3)
      ..write(obj.role)
      ..writeByte(4)
      ..write(obj.joinedAt)
      ..writeByte(5)
      ..write(obj.stats)
      ..writeByte(6)
      ..write(obj.cachedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemberModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MemberStatsModelAdapter extends TypeAdapter<MemberStatsModel> {
  @override
  final int typeId = 2;

  @override
  MemberStatsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MemberStatsModel(
      matchesPlayed: fields[0] as int,
      goals: fields[1] as int,
      assists: fields[2] as int,
      rating: fields[3] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, MemberStatsModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.matchesPlayed)
      ..writeByte(1)
      ..write(obj.goals)
      ..writeByte(2)
      ..write(obj.assists)
      ..writeByte(3)
      ..write(obj.rating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemberStatsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberModel _$MemberModelFromJson(Map<String, dynamic> json) => MemberModel(
      id: json['id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      role: $enumDecode(_$ClubRoleEnumMap, json['role']),
      joinedAt: DateTime.parse(json['joinedAt'] as String),
      stats: json['stats'] == null
          ? null
          : MemberStats.fromJson(json['stats'] as Map<String, dynamic>),
      cachedAt: json['cachedAt'] == null
          ? null
          : DateTime.parse(json['cachedAt'] as String),
    );

Map<String, dynamic> _$MemberModelToJson(MemberModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
      'role': _$ClubRoleEnumMap[instance.role]!,
      'joinedAt': instance.joinedAt.toIso8601String(),
      'stats': instance.stats,
      'cachedAt': instance.cachedAt?.toIso8601String(),
    };

const _$ClubRoleEnumMap = {
  ClubRole.owner: 'owner',
  ClubRole.manager: 'manager',
  ClubRole.member: 'member',
};

MemberStatsModel _$MemberStatsModelFromJson(Map<String, dynamic> json) =>
    MemberStatsModel(
      matchesPlayed: (json['matchesPlayed'] as num?)?.toInt() ?? 0,
      goals: (json['goals'] as num?)?.toInt() ?? 0,
      assists: (json['assists'] as num?)?.toInt() ?? 0,
      rating: (json['rating'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$MemberStatsModelToJson(MemberStatsModel instance) =>
    <String, dynamic>{
      'matchesPlayed': instance.matchesPlayed,
      'goals': instance.goals,
      'assists': instance.assists,
      'rating': instance.rating,
    };
