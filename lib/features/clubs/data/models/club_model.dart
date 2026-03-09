import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/club.dart';

part 'club_model.g.dart';

/// Data model for Club with Hive adapter support.
///
/// Converts to/from Club entity for domain layer compatibility.
/// Includes Hive type annotations for local persistence.
@HiveType(typeId: 0)
@JsonSerializable()
class ClubModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? logoUrl;

  @HiveField(3)
  final int memberCount;

  @HiveField(4)
  final ClubRole userRole;

  @HiveField(5)
  final String? description;

  @HiveField(6)
  final DateTime createdAt;

  @HiveField(7)
  final DateTime? cachedAt;

  ClubModel({
    required this.id,
    required this.name,
    this.logoUrl,
    required this.memberCount,
    required this.userRole,
    this.description,
    required this.createdAt,
    this.cachedAt,
  });

  /// Creates a ClubModel from a Club entity.
  factory ClubModel.fromEntity(Club entity) => ClubModel(
        id: entity.id,
        name: entity.name,
        logoUrl: entity.logoUrl,
        memberCount: entity.memberCount,
        userRole: entity.userRole,
        description: entity.description,
        createdAt: entity.createdAt,
      );

  /// Converts this ClubModel to its entity representation.
  Club toEntity() => Club(
        id: id,
        name: name,
        logoUrl: logoUrl,
        memberCount: memberCount,
        userRole: userRole,
        description: description,
        createdAt: createdAt,
      );

  /// Creates a ClubModel from a JSON map.
  factory ClubModel.fromJson(Map<String, dynamic> json) =>
      _$ClubModelFromJson(json);

  /// Converts this ClubModel to a JSON map.
  Map<String, dynamic> toJson() => _$ClubModelToJson(this);

  /// Creates a ClubModel with cache timestamp.
  factory ClubModel.withTimestamp(ClubModel model, DateTime timestamp) =>
      ClubModel(
        id: model.id,
        name: model.name,
        logoUrl: model.logoUrl,
        memberCount: model.memberCount,
        userRole: model.userRole,
        description: model.description,
        createdAt: model.createdAt,
        cachedAt: timestamp,
      );
}
