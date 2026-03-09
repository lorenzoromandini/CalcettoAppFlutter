import 'dart:convert';

import '../../../../core/services/secure_storage_service.dart';
import '../../features/auth/data/models/user_model.dart';

/// Service for auth-specific token and user data persistence.
///
/// Uses secure storage for sensitive data (tokens) and provides
/// convenience methods for auth-related storage operations.
class AuthStorageService {
  final SecureStorageService _secureStorage;

  AuthStorageService({required SecureStorageService secureStorage})
      : _secureStorage = secureStorage;

  /// Saves JWT token to secure storage.
  Future<void> saveToken(String token) async {
    await _secureStorage.writeJwtToken(token);
  }

  /// Retrieves stored JWT token.
  Future<String?> getToken() async {
    return await _secureStorage.readJwtToken();
  }

  /// Saves serialized user data to secure storage.
  Future<void> saveUser(UserModel user) async {
    final userJson = jsonEncode(user.toJson());
    await _secureStorage.writeToken('user_data', userJson);
  }

  /// Retrieves stored user data.
  Future<UserModel?> getUser() async {
    final userJson = await _secureStorage.readToken('user_data');
    if (userJson != null) {
      final Map<String, dynamic> data = jsonDecode(userJson);
      return UserModel.fromJson(data);
    }
    return null;
  }

  /// Saves user ID to secure storage.
  Future<void> saveUserId(String userId) async {
    await _secureStorage.writeUserId(userId);
  }

  /// Retrieves stored user ID.
  Future<String?> getUserId() async {
    return await _secureStorage.readUserId();
  }

  /// Clears all auth-related data from secure storage.
  Future<void> clearAll() async {
    await _secureStorage.clearAuthTokens();
    await _secureStorage.deleteToken('user_data');
    await clearCredentials();
  }

  /// Stores user credentials for biometric authentication.
  ///
  /// Uses secure storage with key 'stored_credentials'.
  /// Credentials are stored as JSON: {'email': email, 'password': password}
  Future<void> storeCredentials(String email, String password) async {
    final credentialsJson = jsonEncode({
      'email': email,
      'password': password,
    });
    await _secureStorage.writeToken('stored_credentials', credentialsJson);
  }

  /// Retrieves stored credentials for biometric authentication.
  ///
  /// Returns a map with 'email' and 'password' keys, or null if not found.
  Future<Map<String, String>?> getCredentials() async {
    try {
      final credentialsJson =
          await _secureStorage.readToken('stored_credentials');
      if (credentialsJson != null) {
        final Map<String, dynamic> data = jsonDecode(credentialsJson);
        return {
          'email': data['email'] as String,
          'password': data['password'] as String,
        };
      }
    } catch (e) {
      // Return null on any error (not found, parse error, etc.)
    }
    return null;
  }

  /// Clears stored credentials (called on logout).
  Future<void> clearCredentials() async {
    await _secureStorage.deleteToken('stored_credentials');
  }
}
