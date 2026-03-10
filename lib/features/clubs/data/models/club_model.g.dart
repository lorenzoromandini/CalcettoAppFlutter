// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClubModelAdapter extends TypeAdapter<ClubModel> {
  @override
  final int typeId = 0;

  @override
  ClubModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClubModel(
      id: fields[0] as String,
      name: fields[1] as String,
      logoUrl: fields[2] as String?,
      memberCount: fields[3] as int,
      userRole: fields[4] as ClubRole,
      description: fields[5] as String?,
      createdAt: fields[6] as DateTime,
      cachedAt: fields[7] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, ClubModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.logoUrl)
      ..writeByte(3)
      ..write(obj.memberCount)
      ..writeByte(4)
      ..write(obj.userRole)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.cachedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClubModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
