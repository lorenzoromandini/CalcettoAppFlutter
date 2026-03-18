import 'package:dio/dio.dart';

import '../../../../core/utils/result.dart' show Result, Success, FailureResult;
import '../../../../core/errors/failures.dart';
import '../../../../core/services/auth_storage_service.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';
import '../datasources/auth_local_datasource.dart';

/// Implementation of [AuthRepository] using HTTP API client.
///
/// Flow:
/// - login(): Call Next.js API -> Save token -> Cache user data
/// - logout(): Clear session and all stored data
/// - getCurrentUser(): Get cached user data
/// - isAuthenticated(): Check if token exists
class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _apiClient;
  final AuthLocalDataSource _localDataSource;
  final AuthStorageService _authStorageService;

  AuthRepositoryImpl({
    required ApiClient apiClient,
    required AuthLocalDataSource localDataSource,
    required AuthStorageService authStorageService,
  })  : _apiClient = apiClient,
        _localDataSource = localDataSource,
        _authStorageService = authStorageService;

  @override
  Future<Result<User>> login(String email, String password) async {
    try {
      // Call API
      final responseData =
          await _apiClient.login(email: email, password: password);

      // Check if login was successful
      final success = responseData['success'] as bool? ?? false;
      if (!success) {
        final error =
            responseData['error'] as String? ?? 'Invalid email or password';
        return FailureResult(AuthFailure(error));
      }

      // Create user object from API response
      // Backend returns: {success: bool, token: String, user: Map}
      final userData = responseData['user'] as Map<String, dynamic>?;
      if (userData == null) {
        return FailureResult(const AuthFailure('Invalid email or password'));
      }
      final token = responseData['token'] as String?;

      // Create UserModel
      final user = UserModel(
        id: userData['id']?.toString() ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        email: userData['email'] as String? ?? email,
        name: '${userData['firstName'] ?? ''} ${userData['lastName'] ?? ''}'
            .trim(),
        avatarUrl: userData['image'] as String?,
        token: token,
        nickname: userData['nickname'] as String?,
      );

      // Store token if present
      if (token != null) {
        await _authStorageService.saveToken(token);
      }

      // Cache user data
      await _localDataSource.cacheUser(user);

      // Store credentials for biometric authentication
      await _authStorageService.storeCredentials(email, password);

      // Return domain entity
      return Success(user.toEntity());
    } on ApiException catch (e) {
      return FailureResult(AuthFailure(e.message));
    } on DioException catch (e) {
      return FailureResult(ServerFailure('Network error: ${e.message}'));
    } catch (e) {
      return FailureResult(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await _authStorageService.clearAll();
      await _localDataSource.clearCache();
      await _apiClient.logout();
      return const Success(null);
    } catch (e) {
      return FailureResult(CacheFailure('Failed to logout: $e'));
    }
  }

  @override
  Future<Result<User?>> getCurrentUser() async {
    try {
      final storedUser = await _authStorageService.getUser();
      if (storedUser != null) {
        return Success(storedUser.toEntity());
      }

      final cachedUser = await _localDataSource.getCachedUser();
      if (cachedUser != null) {
        return Success(cachedUser.toEntity());
      }

      return const Success(null);
    } catch (e) {
      return FailureResult(CacheFailure('Failed to retrieve user: $e'));
    }
  }

  @override
  Future<Result<User?>> fetchCurrentUserFromServer() async {
    try {
      // Fetch fresh user data from the server
      final responseData = await _apiClient.getSession();

      if (responseData == null || responseData['user'] == null) {
        return const Success(null);
      }

      final userData = Map<String, dynamic>.from(
          responseData['user'] as Map<String, dynamic>);

      final user = UserModel(
        id: userData['id']?.toString() ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        email: userData['email'] as String? ?? '',
        name: '${userData['firstName'] ?? ''} ${userData['lastName'] ?? ''}'
            .trim(),
        avatarUrl: userData['image'] as String?,
        nickname: userData['nickname'] as String?,
      );

      // Update cached user
      await _localDataSource.cacheUser(user);

      return Success(user.toEntity());
    } on ApiException catch (e) {
      return FailureResult(AuthFailure(e.message));
    } on DioException catch (e) {
      return FailureResult(ServerFailure('Network error: ${e.message}'));
    } catch (e) {
      return FailureResult(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Result<bool>> isAuthenticated() async {
    try {
      final token = await _authStorageService.getToken();
      final isAuthenticated = token != null && token.isNotEmpty;
      return Success(isAuthenticated);
    } catch (e) {
      return FailureResult(CacheFailure('Failed to check auth status: $e'));
    }
  }

  @override
  Future<Result<User>> signup({
    required String email,
    required String firstName,
    required String lastName,
    String? nickname,
    required String password,
  }) async {
    try {
      final responseData = await _apiClient.signup(
        email: email,
        firstName: firstName,
        lastName: lastName,
        nickname: nickname,
        password: password,
      );

      final userData = Map<String, dynamic>.from(
          responseData['user'] as Map<String, dynamic>);
      final token = responseData['token'] as String?;

      final user = UserModel(
        id: userData['id']?.toString() ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        email: userData['email'] as String? ?? email,
        name:
            '${userData['firstName'] ?? firstName} ${userData['lastName'] ?? lastName}'
                .trim(),
        avatarUrl: userData['image'] as String?,
        token: token,
        nickname: userData['nickname'] as String?,
      );

      if (token != null) {
        await _authStorageService.saveToken(token);
      }

      await _localDataSource.cacheUser(user);
      await _authStorageService.storeCredentials(email, password);

      return Success(user.toEntity());
    } on ApiException catch (e) {
      return FailureResult(AuthFailure(e.message));
    } on DioException catch (e) {
      return FailureResult(ServerFailure('Network error: ${e.message}'));
    } catch (e) {
      return FailureResult(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Result<User>> updateProfile({
    required String firstName,
    required String lastName,
    String? nickname,
    String? password,
  }) async {
    try {
      final responseData = await _apiClient.updateProfile(
        firstName: firstName,
        lastName: lastName,
        nickname: nickname,
        password: password,
      );

      final userData = Map<String, dynamic>.from(
          responseData['user'] as Map<String, dynamic>);

      final user = UserModel(
        id: userData['id']?.toString() ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        email: userData['email'] as String? ?? '',
        name: '$firstName $lastName',
        avatarUrl: userData['image'] as String?,
        nickname: userData['nickname'] as String?,
      );

      // Update cached user
      await _localDataSource.cacheUser(user);

      return Success(user.toEntity());
    } on ApiException catch (e) {
      return FailureResult(AuthFailure(e.message));
    } on DioException catch (e) {
      return FailureResult(ServerFailure('Network error: ${e.message}'));
    } catch (e) {
      return FailureResult(ServerFailure('Unexpected error: $e'));
    }
  }
}
