import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants/app_constants.dart';
import '../services/cache_service.dart';
import '../services/secure_storage_service.dart';
import '../services/auth_storage_service.dart';
import '../services/connectivity_service.dart';
import '../services/clubs_remote_datasource.dart';
import '../services/clubs_local_datasource.dart';
import '../network/api_client.dart';
import '../providers/connectivity_provider.dart';
import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/usecases/login.dart';
import '../../features/auth/domain/usecases/signup.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/clubs/data/repositories/clubs_repository_impl.dart';
import '../../features/clubs/domain/repositories/clubs_repository.dart';
import '../../features/clubs/presentation/providers/clubs_list_provider.dart';
import '../../features/clubs/presentation/providers/active_club_provider.dart';

// Export connectivity providers for feature modules
export '../providers/connectivity_provider.dart';
// Export clubs providers for feature modules
export '../../features/clubs/presentation/providers/clubs_list_provider.dart';
export '../../features/clubs/presentation/providers/active_club_provider.dart';

/// Provider for ApiClient instance.
final apiClientProvider = Provider<ApiClient>(
  (ref) => ApiClient(),
);

// Global singleton for secure storage to ensure consistency
SecureStorageService? _globalSecureStorage;

/// Provider for SecureStorageService.
/// Uses platform-appropriate implementation (FlutterSecureStorage for mobile/desktop, localStorage for web).
/// Uses a singleton pattern to ensure the same instance is used everywhere.
final secureStorageServiceProvider = Provider<SecureStorageService>(
  (ref) {
    _globalSecureStorage ??= createSecureStorageService();
    return _globalSecureStorage!;
  },
);

/// Provider for AuthStorageService.
final authStorageServiceProvider = Provider<AuthStorageService>(
  (ref) {
    final secureStorage = ref.watch(secureStorageServiceProvider);
    return AuthStorageService(secureStorage: secureStorage);
  },
);

/// Provider for Hive cache box.
final cacheBoxProvider = Provider<Box>((ref) {
  return Hive.box(AppConstants.cacheBoxName);
});

/// Provider for CacheService.
final cacheServiceProvider = Provider<CacheService>(
  (ref) {
    final box = ref.watch(cacheBoxProvider);
    return HiveCacheService(box: box);
  },
);

/// Provider for AuthLocalDataSource.
final authLocalDataSourceProvider = Provider<AuthLocalDataSource>(
  (ref) {
    final cacheService = ref.watch(cacheServiceProvider);
    return AuthLocalDataSourceImpl(cacheService: cacheService);
  },
);

/// Provider for AuthRepository.
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) {
    final apiClient = ref.watch(apiClientProvider);
    final localDataSource = ref.watch(authLocalDataSourceProvider);
    final authStorageService = ref.watch(authStorageServiceProvider);

    return AuthRepositoryImpl(
      apiClient: apiClient,
      localDataSource: localDataSource,
      authStorageService: authStorageService,
    );
  },
);

/// Provider for LoginAsyncUseCase.
final loginAsyncUseCaseProvider = Provider<LoginAsyncUseCase>(
  (ref) {
    final repository = ref.watch(authRepositoryProvider);
    return LoginAsyncUseCase(repository);
  },
);

/// Provider for signup use case.
final signupAsyncUseCaseProvider = Provider<SignupAsyncUseCase>(
  (ref) {
    final repository = ref.watch(authRepositoryProvider);
    return SignupAsyncUseCase(repository);
  },
);

// ============================================================================
// Clubs Feature Providers
// ============================================================================

/// Provider for Dio instance (shared across datasources).
/// Uses the authenticated Dio from ApiClient to ensure auth token is sent.
final dioProvider = Provider<Dio>(
  (ref) {
    final apiClient = ref.watch(apiClientProvider);
    // Use the Dio instance from ApiClient which has auth interceptor
    return apiClient.dio;
  },
);

/// Provider for ClubsRemoteDataSource.
final clubsRemoteDataSourceProvider = Provider<ClubsRemoteDataSource>(
  (ref) {
    final dio = ref.watch(dioProvider);
    return DioClubsRemoteDataSource(dio: dio);
  },
);

/// Provider for ClubsLocalDataSource.
final clubsLocalDataSourceProvider = Provider<ClubsLocalDataSource>(
  (ref) {
    final box = ref.watch(cacheBoxProvider);
    return HiveClubsLocalDataSource(box: box);
  },
);

/// Provider for ClubsRepository.
final clubsRepositoryProvider = Provider<ClubsRepository>(
  (ref) {
    final remote = ref.watch(clubsRemoteDataSourceProvider);
    final local = ref.watch(clubsLocalDataSourceProvider);
    final connectivity = ref.watch(connectivityServiceProvider);

    return ClubsRepositoryImpl(
      remote: remote,
      local: local,
      connectivity: connectivity,
    );
  },
);
