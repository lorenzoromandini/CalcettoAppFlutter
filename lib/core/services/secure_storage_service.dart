import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/app_constants.dart';

/// Abstract interface for secure storage operations.
///
/// Used for storing sensitive data like JWT tokens.
abstract class SecureStorageService {
  Future<void> writeToken(String key, String value);
  Future<String?> readToken(String key);
  Future<void> deleteToken(String key);
  Future<void> clearAll();
}

/// Implementation of [SecureStorageService] using flutter_secure_storage.
class FlutterSecureStorageService implements SecureStorageService {
  final FlutterSecureStorage _storage;

  FlutterSecureStorageService({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  @override
  Future<void> writeToken(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  @override
  Future<String?> readToken(String key) async {
    return await _storage.read(key: key);
  }

  @override
  Future<void> deleteToken(String key) async {
    await _storage.delete(key: key);
  }

  @override
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}

/// Convenience methods for auth-specific token operations.
extension AuthSecureStorage on SecureStorageService {
  Future<void> writeJwtToken(String token) async {
    await writeToken(AppConstants.jwtTokenKey, token);
  }

  Future<String?> readJwtToken() async {
    return await readToken(AppConstants.jwtTokenKey);
  }

  Future<void> writeRefreshToken(String token) async {
    await writeToken(AppConstants.refreshTokenKey, token);
  }

  Future<String?> readRefreshToken() async {
    return await readToken(AppConstants.refreshTokenKey);
  }

  Future<void> writeUserId(String userId) async {
    await writeToken(AppConstants.userIdKey, userId);
  }

  Future<String?> readUserId() async {
    return await readToken(AppConstants.userIdKey);
  }

  Future<void> clearAuthTokens() async {
    await deleteToken(AppConstants.jwtTokenKey);
    await deleteToken(AppConstants.refreshTokenKey);
    await deleteToken(AppConstants.userIdKey);
  }
}
