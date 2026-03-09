/// User entity representing the core business object for authentication.
///
/// This is an immutable domain entity with no Flutter dependencies.
/// Used across all layers of the application.
class User {
  /// Unique user identifier.
  final String id;

  /// User email address.
  final String email;

  /// User display name.
  final String name;

  /// Optional avatar URL.
  final String? avatarUrl;

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.avatarUrl,
  });

  /// Returns true if the user has a profile avatar.
  bool get hasAvatar => avatarUrl != null && avatarUrl!.isNotEmpty;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          name == other.name &&
          avatarUrl == other.avatarUrl;

  @override
  int get hashCode => Object.hash(id, email, name, avatarUrl);

  @override
  String toString() => 'User(id: $id, email: $email, name: $name)';
}
