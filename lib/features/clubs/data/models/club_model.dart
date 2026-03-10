import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/club.dart';

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
  /// Handles API field name differences:
  /// - API sends 'imageUrl' but we use 'logoUrl'
  /// - API sends 'id' as int but we need String
  /// - API doesn't send 'userRole' - defaults to member
  factory ClubModel.fromJson(Map<String, dynamic> json) {
    return ClubModel(
      id: json['id'].toString(), // Convert int/any to String
      name: json['name'] as String,
      logoUrl: json['imageUrl'] as String?, // API uses imageUrl
      memberCount: (json['memberCount'] as num?)?.toInt() ?? 1,
      userRole: _parseUserRole(json['userRole']), // API might not send this
      description: json['description'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
    );
  }

  /// Helper to parse userRole from API or default to member
  static ClubRole _parseUserRole(dynamic value) {
    if (value == null) return ClubRole.member;
    if (value is String) {
      switch (value.toLowerCase()) {
        case 'owner':
          return ClubRole.owner;
        case 'manager':
          return ClubRole.manager;
        case 'member':
        default:
          return ClubRole.member;
      }
    }
    return ClubRole.member;
  }

  /// Converts this ClubModel to a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'logoUrl': logoUrl,
        'memberCount': memberCount,
        'userRole': userRole.name,
        'description': description,
        'createdAt': createdAt.toIso8601String(),
        'cachedAt': cachedAt?.toIso8601String(),
      };

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
