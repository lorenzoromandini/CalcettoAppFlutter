// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_privilege.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClubPrivilegeAdapter extends TypeAdapter<ClubPrivilege> {
  @override
  final int typeId = 5;

  @override
  ClubPrivilege read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ClubPrivilege.OWNER;
      case 1:
        return ClubPrivilege.MANAGER;
      case 2:
        return ClubPrivilege.MEMBER;
      default:
        return ClubPrivilege.OWNER;
    }
  }

  @override
  void write(BinaryWriter writer, ClubPrivilege obj) {
    switch (obj) {
      case ClubPrivilege.OWNER:
        writer.writeByte(0);
        break;
      case ClubPrivilege.MANAGER:
        writer.writeByte(1);
        break;
      case ClubPrivilege.MEMBER:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClubPrivilegeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
