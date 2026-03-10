import 'package:dio/dio.dart';

import '../constants/app_constants.dart';
import '../services/secure_storage_service.dart';

// Global storage instance to ensure consistency across the app
SecureStorageService? _globalStorage;

SecureStorageService _getStorage() {
  _globalStorage ??= createSecureStorageService();
  return _globalStorage!;
}

/// API client for connecting to Next.js backend.
///
/// Base URL: http://localhost:3000/api (for local development)
/// Change [baseUrl] for production deployment.
class ApiClient {
  static const String _baseUrl = 'http://localhost:8080';
  final Dio _dio;
  SecureStorageService get _storage => _getStorage();

  ApiClient()
      : _dio = Dio(BaseOptions(
          baseUrl: _baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: {
            'Content-Type': 'application/json',
          },
        )) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.readJwtToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          await _storage.clearAuthTokens();
        }
        return handler.next(error);
      },
    ));
  }

  // AUTH ENDPOINTS

  /// Sign up a new user
  /// Returns: {success: bool, token: String, user: Map} on success
  /// Throws: DioException with error message on failure
  Future<Map<String, dynamic>> signup({
    required String email,
    required String firstName,
    required String lastName,
    String? nickname,
    required String password,
  }) async {
    try {
      final response = await _dio.post('/auth/signup', data: {
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'nickname': nickname,
        'password': password,
      });
      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      final errorMessage = e.response?.data?['error'] ??
          (e.response?.data?['message'] ?? 'Signup failed');
      throw ApiException(_translateError(errorMessage));
    }
  }

  /// Login with email and password
  /// Returns: {success: bool, token: String, user: Map} on success
  /// Throws: DioException with error message on failure
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      final data = Map<String, dynamic>.from(response.data);

      // Extract and store token
      if (data.containsKey('token')) {
        final token = data['token'] as String;
        print('API CLIENT: Saving token, length: ${token.length}');
        await _storage.writeJwtToken(token);
        print('API CLIENT: Token saved');
      }

      return data;
    } on DioException catch (e) {
      final errorMessage = e.response?.data?['error'] ??
          (e.response?.data?['message'] ?? 'Login failed');
      throw ApiException(_translateError(errorMessage));
    }
  }

  /// Get current user session
  /// Returns: {user: Map} or null if not authenticated
  Future<Map<String, dynamic>?> getSession() async {
    try {
      final response = await _dio.get('/auth/session');
      return response.data as Map<String, dynamic>?;
    } on DioException {
      return null;
    }
  }

  /// Logout current user
  Future<void> logout() async {
    await _storage.clearAuthTokens();
    try {
      await _dio.post('/auth/logout');
    } catch (_) {
      // Ignore errors on logout
    }
  }

  /// Delete JWT token from storage
  Future<void> clearToken() async {
    await _storage.clearAuthTokens();
  }

  /// Get the Dio instance for use by other services
  Dio get dio => _dio;

  /// Translate Italian error messages to English
  String _translateError(String error) {
    // Italian -> English translations
    final translations = {
      'Email o password non corretti': 'Invalid email or password',
      'Email e password sono obbligatori': 'Email and password are required',
      'Si è verificato un errore': 'An error occurred',
      'Questa email è già registrata': 'This email is already registered',
      'La password deve essere di almeno 6 caratteri':
          'Password must be at least 6 characters',
      'Il nome deve avere almeno 2 caratteri':
          'First name must be at least 2 characters',
      'Il cognome deve avere almeno 2 caratteri':
          'Last name must be at least 2 characters',
    };
    return translations[error] ?? error;
  }
}

/// Custom exception for API errors
class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => 'ApiException: $message';
}
