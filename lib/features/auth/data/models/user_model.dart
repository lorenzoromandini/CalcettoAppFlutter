import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user.dart';

part 'user_model.g.dart';

/// Data model for User entity with JSON serialization support.
///
/// Separate from domain entity to avoid freezed inheritance issues.
/// Used for API responses and local storage.
@JsonSerializable()
class UserModel {
  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.avatarUrl,
    this.token,
  });

  /// Unique user identifier.
  final String id;

  /// User email address.
  final String email;

  /// User display name.
  final String name;

  /// Optional avatar URL.
  final String? avatarUrl;

  /// JWT token received from authentication response.
  /// Not part of the domain entity - data layer only.
  final String? token;

  /// Creates a UserModel from JSON map.
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Converts UserModel to JSON map.
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  /// Creates a UserModel from a domain User entity.
  factory UserModel.fromEntity(User user) => UserModel(
        id: user.id,
        email: user.email,
        name: user.name,
        avatarUrl: user.avatarUrl,
      );

  /// Converts this model to a domain User entity.
  User toEntity() => User(
        id: id,
        email: email,
        name: name,
        avatarUrl: avatarUrl,
      );
}
