import 'package:serverpod/serverpod.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:calcetto_backend_server/src/generated/protocol.dart';

/// Authentication endpoint - handles login and signup
class AuthEndpoint extends Endpoint {
  /// Authenticates user with email and password
  Future<AuthenticationResponse> login(
    Session session,
    String email,
    String password,
  ) async {
    var users = await UserInfo.db.find(
      session,
      where: (t) => t.email.equals(email),
    );

    if (users.isEmpty) {
      return AuthenticationResponse(
        success: false,
        error: 'Invalid email or password',
      );
    }

    var user = users.first;
    var hashedPassword = _hashPassword(password, user.passwordSalt);

    if (hashedPassword != user.passwordHash) {
      return AuthenticationResponse(
        success: false,
        error: 'Invalid email or password',
      );
    }

    user.lastLogin = DateTime.now();
    await UserInfo.db.updateRow(session, user);

    var token = _generateToken(user);

    return AuthenticationResponse(
      success: true,
      token: token,
      user: user,
    );
  }

  /// Register new user
  Future<AuthenticationResponse> signup(
    Session session,
    String email,
    String password,
    String firstName,
    String lastName,
    String? nickname,
    String? imageUrl,
  ) async {
    var existingUsers = await UserInfo.db.find(
      session,
      where: (t) => t.email.equals(email),
    );

    if (existingUsers.isNotEmpty) {
      return AuthenticationResponse(
        success: false,
        error: 'Email already registered',
      );
    }

    if (password.length < 6) {
      return AuthenticationResponse(
        success: false,
        error: 'Password must be at least 6 characters',
      );
    }

    var salt = _generateSalt();
    var passwordHash = _hashPassword(password, salt);

    var user = UserInfo(
      email: email,
      passwordHash: passwordHash,
      passwordSalt: salt,
      firstName: firstName,
      lastName: lastName,
      nickname: nickname,
      imageUrl: imageUrl,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    var createdUser = await UserInfo.db.insertRow(session, user);
    var token = _generateToken(createdUser);

    return AuthenticationResponse(
      success: true,
      token: token,
      user: createdUser,
    );
  }

  String _generateSalt() {
    var random =
        List.generate(16, (_) => DateTime.now().millisecondsSinceEpoch % 256);
    return base64Url.encode(random);
  }

  String _hashPassword(String password, String salt) {
    var bytes = utf8.encode(password + salt);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  String _generateToken(UserInfo user) {
    var payload = base64Url.encode(utf8.encode(jsonEncode({
      'user_id': user.id,
      'email': user.email,
      'exp': DateTime.now().add(const Duration(days: 7)).millisecondsSinceEpoch,
    })));
    return payload;
  }
}
