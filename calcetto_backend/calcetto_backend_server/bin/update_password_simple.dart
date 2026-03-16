import 'dart:io';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:postgres/postgres.dart';

void main() async {
  final email = 'mario.rossi@example.com';
  final newPassword = 'password';

  final conn = await Connection.open(
    Endpoint(
      host: 'localhost',
      port: 5432,
      database: 'calcetto',
      username: 'calcetto',
      password: 'calcetto',
    ),
    settings: ConnectionSettings(sslMode: SslMode.disable),
  );

  try {
    final result = await conn.execute(
      'SELECT id, email, "firstName", "lastName" FROM user_info WHERE email = @email',
      parameters: {'email': email},
    );

    if (result.isEmpty) {
      print('User not found: $email');
      await conn.close();
      exit(1);
    }

    final row = result.first;
    print(
        'Found user: ${row['email']} (${row['firstName']} ${row['lastName']})');

    final salt = _generateSalt();
    final passwordHash = _hashPassword(newPassword, salt);

    await conn.execute(
      'UPDATE user_info SET "passwordHash" = @hash, "passwordSalt" = @salt, "updatedAt" = NOW() WHERE email = @email',
      parameters: {
        'hash': passwordHash,
        'salt': salt,
        'email': email,
      },
    );

    print('Password updated successfully for $email');
    print('New password: $newPassword');
  } finally {
    await conn.close();
  }
}

String _generateSalt() {
  final random =
      List.generate(16, (_) => DateTime.now().millisecondsSinceEpoch % 256);
  return base64Url.encode(random);
}

String _hashPassword(String password, String salt) {
  final bytes = utf8.encode(password + salt);
  final digest = sha256.convert(bytes);
  return digest.toString();
}
