import 'package:hive_flutter/hive_flutter.dart';

/// Player position enum representing field positions.
/// Maps to Serverpod PlayerPosition enum: GK=0, DEF=1, MID=2, ST=3
@HiveType(typeId: 10)
enum PlayerPosition {
  @HiveField(0)
  GK, // Goalkeeper
  @HiveField(1)
  DEF, // Defender
  @HiveField(2)
  MID, // Midfielder
  @HiveField(3)
  ST; // Striker

  /// Returns display name for the position.
  String get displayName {
    switch (this) {
      case PlayerPosition.GK:
        return 'Portiere';
      case PlayerPosition.DEF:
        return 'Difensore';
      case PlayerPosition.MID:
        return 'Centrocampista';
      case PlayerPosition.ST:
        return 'Attaccante';
    }
  }

  /// Returns abbreviation for the position.
  String get abbreviation {
    switch (this) {
      case PlayerPosition.GK:
        return 'GK';
      case PlayerPosition.DEF:
        return 'DEF';
      case PlayerPosition.MID:
        return 'MID';
      case PlayerPosition.ST:
        return 'ST';
    }
  }

  /// Maps from Serverpod PlayerPosition index
  static PlayerPosition fromIndex(int index) {
    switch (index) {
      case 0:
        return PlayerPosition.GK;
      case 1:
        return PlayerPosition.DEF;
      case 2:
        return PlayerPosition.MID;
      case 3:
      default:
        return PlayerPosition.ST;
    }
  }

  /// Maps from Serverpod PlayerPosition name
  static PlayerPosition fromName(String name) {
    switch (name.toUpperCase()) {
      case 'GK':
        return PlayerPosition.GK;
      case 'DEF':
        return PlayerPosition.DEF;
      case 'MID':
        return PlayerPosition.MID;
      case 'ST':
      default:
        return PlayerPosition.ST;
    }
  }
}
