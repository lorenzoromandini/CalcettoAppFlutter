import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/club.dart';
import '../../domain/entities/club_privilege.dart';

part 'club_model.g.dart';

/// Data model for Club with Hive adapter support.
///
/// Converts to/from Club entity for domain layer compatibility.
/// Includes Hive type annotations for local persistence.
@HiveType(typeId: 0)
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
  final ClubPrivilege userPrivilege;

  @HiveField(5)
  final String? description;

  @HiveField(6)
  final DateTime createdAt;

  @HiveField(7)
  final DateTime? cachedAt;

  @HiveField(8)
  final DateTime? deletedAt;

  ClubModel({
    required this.id,
    required this.name,
    this.logoUrl,
    required this.memberCount,
    required this.userPrivilege,
    this.description,
    required this.createdAt,
    this.cachedAt,
    this.deletedAt,
  });

  /// Creates a ClubModel from a Club entity.
  factory ClubModel.fromEntity(Club entity) => ClubModel(
        id: entity.id,
        name: entity.name,
        logoUrl: entity.logoUrl,
        memberCount: entity.memberCount,
        userPrivilege: entity.userPrivilege,
        description: entity.description,
        createdAt: entity.createdAt,
        deletedAt: entity.deletedAt,
      );

  /// Converts this ClubModel to its entity representation.
  Club toEntity() => Club(
        id: id,
        name: name,
        logoUrl: logoUrl,
        memberCount: memberCount,
        userPrivilege: userPrivilege,
        description: description,
        createdAt: createdAt,
        deletedAt: deletedAt,
      );

  /// Creates a ClubModel from a JSON map.
  /// Handles API field name differences:
  /// - API sends 'imageUrl' but we use 'logoUrl'
  /// - API sends 'id' as UUID string
  /// - API sends 'privilege' as int index
  factory ClubModel.fromJson(Map<String, dynamic> json) {
    return ClubModel(
      id: json['id'] as String, // UUID string
      name: json['name'] as String,
      logoUrl: json['imageUrl'] as String?, // API uses imageUrl
      memberCount: (json['memberCount'] as num?)?.toInt() ?? 1,
      userPrivilege: _parsePrivilege(json['privilege']), // API sends privilege
      description: json['description'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      deletedAt: json['deletedAt'] != null
          ? DateTime.parse(json['deletedAt'] as String)
          : null,
    );
  }

  /// Helper to parse privilege from API or default to MEMBER
  /// Handles both String names and int indices from Serverpod
  static ClubPrivilege _parsePrivilege(dynamic value) {
    if (value == null) return ClubPrivilege.MEMBER;
    if (value is int) {
      // Serverpod sends enum as index: 0=OWNER, 1=MANAGER, 2=MEMBER
      return ClubPrivilege.fromIndex(value);
    }
    if (value is String) {
      return ClubPrivilege.fromName(value);
    }
    return ClubPrivilege.MEMBER;
  }

  /// Converts this ClubModel to a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'logoUrl': logoUrl,
        'memberCount': memberCount,
        'privilege': userPrivilege.name,
        'description': description,
        'createdAt': createdAt.toIso8601String(),
        'cachedAt': cachedAt?.toIso8601String(),
        'deletedAt': deletedAt?.toIso8601String(),
      };

  /// Creates a ClubModel with cache timestamp.
  factory ClubModel.withTimestamp(ClubModel model, DateTime timestamp) =>
      ClubModel(
        id: model.id,
        name: model.name,
        logoUrl: model.logoUrl,
        memberCount: model.memberCount,
        userPrivilege: model.userPrivilege,
        description: model.description,
        createdAt: model.createdAt,
        cachedAt: timestamp,
      );
}
