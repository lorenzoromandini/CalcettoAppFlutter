import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/app_constants.dart';

/// Abstract interface for secure storage operations.
abstract class SecureStorageService {
  Future<void> writeToken(String key, String value);
  Future<String?> readToken(String key);
  Future<void> deleteToken(String key);
  Future<void> clearAll();
}

/// Factory to get the appropriate secure storage implementation.
SecureStorageService createSecureStorageService() {
  if (kIsWeb) {
    return HiveSecureStorageService();
  }
  return FlutterSecureStorageService();
}

/// Implementation using flutter_secure_storage for mobile/desktop.
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

/// Web implementation using localStorage for persistence.
class HiveSecureStorageService implements SecureStorageService {
  @override
  Future<void> writeToken(String key, String value) async {
    try {
      // Use 'auth-token' key to match backend's getUserIdFromRequest expectation
      final storageKey = (key == AppConstants.jwtTokenKey) ? 'auth-token' : key;
      window.localStorage[storageKey] = value;
    } catch (e) {
      // Error handling without logging
    }
  }

  @override
  Future<String?> readToken(String key) async {
    try {
      // Use 'auth-token' key to match backend's getUserIdFromRequest expectation
      final storageKey = (key == AppConstants.jwtTokenKey) ? 'auth-token' : key;
      final value = window.localStorage[storageKey];
      return value;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> deleteToken(String key) async {
    try {
      final storageKey = (key == AppConstants.jwtTokenKey) ? 'auth-token' : key;
      window.localStorage.remove(storageKey);
    } catch (e) {
      // Error handling without logging
    }
  }

  @override
  Future<void> clearAll() async {
    try {
      window.localStorage.remove('auth-token');
      window.localStorage.remove(AppConstants.refreshTokenKey);
      window.localStorage.remove(AppConstants.userIdKey);
      window.localStorage.remove('user_data');
      window.localStorage.remove('stored_credentials');
    } catch (e) {
      // Error handling without logging
    }
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
