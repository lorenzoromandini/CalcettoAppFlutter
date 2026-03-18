import 'package:serverpod/serverpod.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:calcetto_backend_server/src/generated/protocol.dart';

/// Authentication endpoint - handles login and signup with secure password hashing
class AuthEndpoint extends Endpoint {
  /// Authenticates user with email and password
  Future<Map<String, dynamic>> login(
    Session session,
    String email,
    String password,
  ) async {
    var users = await User.db.find(
      session,
      where: (t) => t.email.equals(email),
    );

    if (users.isEmpty) {
      return {
        'success': false,
        'error': 'Invalid email or password',
      };
    }

    var user = users.first;

    // Verify hashed password
    if (!_verifyPassword(password, user.password)) {
      return {
        'success': false,
        'error': 'Invalid email or password',
      };
    }

    user.lastLogin = DateTime.now();
    await User.db.updateRow(session, user);

    var token = _generateToken(user);

    return {
      'success': true,
      'token': token,
      'user': user.toJson(),
    };
  }

  /// Register new user with hashed password
  Future<Map<String, dynamic>> signup(
    Session session,
    String email,
    String password,
    String firstName,
    String lastName,
    String? nickname,
    String? imageUrl,
  ) async {
    var existingUsers = await User.db.find(
      session,
      where: (t) => t.email.equals(email),
    );

    if (existingUsers.isNotEmpty) {
      return {
        'success': false,
        'error': 'Email already registered',
      };
    }

    if (password.length < 6) {
      return {
        'success': false,
        'error': 'Password must be at least 6 characters',
      };
    }

    // Hash the password before storing
    final hashedPassword = _hashPassword(password);

    var user = User(
      email: email,
      password: hashedPassword,
      firstName: firstName,
      lastName: lastName,
      nickname: nickname,
      imageUrl: imageUrl,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    var createdUser = await User.db.insertRow(session, user);
    var token = _generateToken(createdUser);

    return {
      'success': true,
      'token': token,
      'user': createdUser.toJson(),
    };
  }

  /// Get current authenticated user
  Future<User?> getCurrentUser(Session session) async {
    final userIdStr = _extractUserIdFromToken(session);
    if (userIdStr == null) return null;

    final userId = UuidValue.fromString(userIdStr);
    return await User.db.findById(session, userId);
  }

  /// Logout current user
  /// Returns success message
  Future<Map<String, dynamic>> logout(Session session) async {
    // In a real implementation, you might want to invalidate the token
    // For now, just return success as the client will clear local storage
    return {
      'success': true,
      'message': 'Logged out successfully',
    };
  }

  /// Hash password using SHA-256 with salt
  String _hashPassword(String password) {
    // Generate a random salt
    final salt = DateTime.now().millisecondsSinceEpoch.toString();
    // Combine password + salt and hash
    final bytes = utf8.encode(password + salt);
    final digest = sha256.convert(bytes);
    // Store salt + hash together
    return '$salt:${digest.toString()}';
  }

  /// Verify password against stored hash
  bool _verifyPassword(String password, String storedHash) {
    try {
      // Split stored hash into salt and hash
      final parts = storedHash.split(':');
      if (parts.length != 2) return false;

      final salt = parts[0];
      final originalHash = parts[1];

      // Hash provided password with same salt
      final bytes = utf8.encode(password + salt);
      final digest = sha256.convert(bytes);

      // Compare hashes
      return digest.toString() == originalHash;
    } catch (e) {
      return false;
    }
  }

  String _generateToken(User user) {
    // Simple JWT-like token (in production, use proper JWT library)
    final payload = jsonEncode({
      'user_id': user.id?.toString(),
      'email': user.email,
      'exp':
          DateTime.now().add(Duration(days: 7)).millisecondsSinceEpoch ~/ 1000,
    });
    return base64UrlEncode(utf8.encode(payload));
  }

  /// Update user profile
  Future<Map<String, dynamic>> updateProfile(
    Session session,
    String firstName,
    String lastName,
    String? nickname,
    String? password,
  ) async {
    final userIdStr = _extractUserIdFromToken(session);
    if (userIdStr == null) {
      return {
        'success': false,
        'error': 'Not authenticated',
      };
    }

    final userId = UuidValue.fromString(userIdStr);
    var user = await User.db.findById(session, userId);

    if (user == null) {
      return {
        'success': false,
        'error': 'User not found',
      };
    }

    // Update user fields
    user.firstName = firstName;
    user.lastName = lastName;
    // Update nickname - set to null if empty string
    user.nickname = nickname?.isNotEmpty == true ? nickname : null;
    if (password != null && password.isNotEmpty) {
      if (password.length < 6) {
        return {
          'success': false,
          'error': 'Password must be at least 6 characters',
        };
      }
      user.password = _hashPassword(password);
    }
    user.updatedAt = DateTime.now();

    await User.db.updateRow(session, user);

    return {
      'success': true,
      'user': user.toJson(),
    };
  }

  /// Extract user ID from JWT token
  String? _extractUserIdFromToken(Session session) {
    final authKey = session.authenticationKey;
    if (authKey == null) return null;

    try {
      // Remove "bearer " prefix if present (case insensitive)
      final token = authKey.toLowerCase().startsWith('bearer ')
          ? authKey.substring(7)
          : authKey;

      // Decode base64 token
      final decoded = utf8.decode(base64Url.decode(token));
      final payload = jsonDecode(decoded) as Map<String, dynamic>;

      return payload['user_id'] as String?;
    } catch (e) {
      return null;
    }
  }
}
