import 'dart:convert';
import 'package:crypto/crypto.dart';

void main() {
  // Test the password hashing
  final password = 'password';
  final salt = '1742151600000';

  // Combine and hash
  final combined = password + salt;
  final bytes = utf8.encode(combined);
  final digest = sha256.convert(bytes);

  print('Password: $password');
  print('Salt: $salt');
  print('Combined: $combined');
  print('Hash: ${digest.toString()}');
  print('Full stored: $salt:${digest.toString()}');

  // Verify
  final storedHash = '$salt:${digest.toString()}';
  final parts = storedHash.split(':');
  final extractedSalt = parts[0];
  final originalHash = parts[1];

  final verifyBytes = utf8.encode(password + extractedSalt);
  final verifyDigest = sha256.convert(verifyBytes);

  print('');
  print('Verification:');
  print('Extracted salt: $extractedSalt');
  print('Original hash: $originalHash');
  print('Computed hash: ${verifyDigest.toString()}');
  print('Match: ${verifyDigest.toString() == originalHash}');
}
