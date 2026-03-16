// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_member_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClubMemberModelAdapter extends TypeAdapter<ClubMemberModel> {
  @override
  final int typeId = 3;

  @override
  ClubMemberModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClubMemberModel(
      id: fields[0] as String,
      userId: fields[1] as String,
      clubId: fields[2] as String,
      name: fields[3] as String,
      avatarUrl: fields[4] as String?,
      primaryPosition: fields[5] as PlayerPosition,
      secondaryPositions: (fields[6] as List).cast<PlayerPosition>(),
      privilege: fields[7] as ClubPrivilege,
      joinedAt: fields[8] as DateTime,
      jerseyNumber: fields[9] as int?,
      symbol: fields[10] as String?,
      nationality: fields[11] as String?,
      stats: fields[12] as ClubMemberStatsModel?,
      cachedAt: fields[13] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, ClubMemberModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.clubId)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.avatarUrl)
      ..writeByte(5)
      ..write(obj.primaryPosition)
      ..writeByte(6)
      ..write(obj.secondaryPositions)
      ..writeByte(7)
      ..write(obj.privilege)
      ..writeByte(8)
      ..write(obj.joinedAt)
      ..writeByte(9)
      ..write(obj.jerseyNumber)
      ..writeByte(10)
      ..write(obj.symbol)
      ..writeByte(11)
      ..write(obj.nationality)
      ..writeByte(12)
      ..write(obj.stats)
      ..writeByte(13)
      ..write(obj.cachedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClubMemberModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ClubMemberStatsModelAdapter extends TypeAdapter<ClubMemberStatsModel> {
  @override
  final int typeId = 4;

  @override
  ClubMemberStatsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClubMemberStatsModel(
      matchesPlayed: fields[0] as int,
      goals: fields[1] as int,
      assists: fields[2] as int,
      averageRating: fields[3] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, ClubMemberStatsModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.matchesPlayed)
      ..writeByte(1)
      ..write(obj.goals)
      ..writeByte(2)
      ..write(obj.assists)
      ..writeByte(3)
      ..write(obj.averageRating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClubMemberStatsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClubMemberModel _$ClubMemberModelFromJson(Map<String, dynamic> json) =>
    ClubMemberModel(
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
          : ClubMemberStatsModel.fromJson(
              json['stats'] as Map<String, dynamic>),
      cachedAt: json['cachedAt'] == null
          ? null
          : DateTime.parse(json['cachedAt'] as String),
    );

Map<String, dynamic> _$ClubMemberModelToJson(ClubMemberModel instance) =>
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
      'cachedAt': instance.cachedAt?.toIso8601String(),
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

ClubMemberStatsModel _$ClubMemberStatsModelFromJson(
        Map<String, dynamic> json) =>
    ClubMemberStatsModel(
      matchesPlayed: (json['matchesPlayed'] as num?)?.toInt() ?? 0,
      goals: (json['goals'] as num?)?.toInt() ?? 0,
      assists: (json['assists'] as num?)?.toInt() ?? 0,
      averageRating: (json['averageRating'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ClubMemberStatsModelToJson(
        ClubMemberStatsModel instance) =>
    <String, dynamic>{
      'matchesPlayed': instance.matchesPlayed,
      'goals': instance.goals,
      'assists': instance.assists,
      'averageRating': instance.averageRating,
    };
