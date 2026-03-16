import 'package:calcetto_backend_server/src/generated/protocol.dart';
import 'package:calcetto_backend_server/src/generated/endpoints.dart';
import 'package:serverpod/serverpod.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

void main(List<String> args) async {
  final email = 'mario.rossi@example.com';
  final newPassword = 'password';

  // Initialize Serverpod
  final pod = Serverpod(args, Protocol(), Endpoints());
  await pod.start();

  // Create session
  final session = await pod.createSession();

  try {
    // Find user
    final users = await UserInfo.db.find(
      session,
      where: (t) => t.email.equals(email),
    );

    if (users.isEmpty) {
      print('User not found: $email');
      await pod.shutdown();
      return;
    }

    final user = users.first;
    print('Found user: ${user.email} (${user.firstName} ${user.lastName})');

    // Generate new salt and hash
    final salt = _generateSalt();
    final passwordHash = _hashPassword(newPassword, salt);

    // Update user
    user.passwordHash = passwordHash;
    user.passwordSalt = salt;
    user.updatedAt = DateTime.now();

    await UserInfo.db.updateRow(session, user);

    print('✓ Password updated successfully for $email');
    print('  New password: $newPassword');
  } finally {
    await session.close();
    await pod.shutdown();
  }
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
