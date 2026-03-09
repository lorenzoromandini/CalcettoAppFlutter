import '../../../../core/utils/result.dart' show Result, Success, FailureResult;
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/services/cache_service.dart';
import '../../../../core/services/auth_storage_service.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../datasources/auth_local_datasource.dart';

/// Implementation of [AuthRepository] coordinating between data sources.
///
/// Handles the following flow:
/// - login(): Remote API call -> Save tokens -> Cache user -> Return User entity
/// - getCurrentUser(): Secure storage -> Cache fallback -> Return User entity
/// - isAuthenticated(): Check if valid token exists
/// - logout(): Clear all stored data
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;
  final AuthStorageService _authStorageService;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
    required AuthStorageService authStorageService,
    required CacheService cacheService,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _authStorageService = authStorageService;

  @override
  Future<Result<User>> login(String email, String password) async {
    try {
      // Call remote API
      final userModel = await _remoteDataSource.login(email, password);

      // On success: save token and cache user
      if (userModel.token != null) {
        await _authStorageService.saveToken(userModel.token!);
      }
      await _authStorageService.saveUser(userModel);
      await _localDataSource.cacheUser(userModel);

      // Store credentials for biometric authentication
      await _authStorageService.storeCredentials(email, password);

      // Return domain entity
      return Success(userModel.toEntity());
    } on AuthException catch (e) {
      return FailureResult(AuthFailure(e.message));
    } on ServerException catch (e) {
      return FailureResult(ServerFailure(e.message));
    } catch (e) {
      return FailureResult(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await _authStorageService.clearAll();
      await _localDataSource.clearCache();
      // Note: clearAll() also clears stored credentials
      return const Success(null);
    } catch (e) {
      return FailureResult(CacheFailure('Failed to clear session: $e'));
    }
  }

  @override
  Future<Result<User?>> getCurrentUser() async {
    try {
      // First try secure storage
      final storedUser = await _authStorageService.getUser();
      if (storedUser != null) {
        return Success(storedUser.toEntity());
      }

      // Fallback to cache
      final cachedUser = await _localDataSource.getCachedUser();
      if (cachedUser != null) {
        return Success(cachedUser.toEntity());
      }

      // No user found
      return const Success(null);
    } catch (e) {
      return FailureResult(CacheFailure('Failed to retrieve user: $e'));
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
}
