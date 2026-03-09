import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/app_constants.dart';
import '../services/cache_service.dart';
import '../services/secure_storage_service.dart';
import '../services/auth_storage_service.dart';
import '../network/api_client.dart';
import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/usecases/login.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';

/// Provider for ApiClient instance.
final apiClientProvider = Provider<ApiClient>(
  (ref) => ApiClient(),
);

/// Provider for FlutterSecureStorage instance.
final secureStorageProvider = Provider<FlutterSecureStorage>(
  (ref) => const FlutterSecureStorage(),
);

/// Provider for SecureStorageService.
final secureStorageServiceProvider = Provider<SecureStorageService>(
  (ref) {
    final storage = ref.watch(secureStorageProvider);
    return FlutterSecureStorageService(storage: storage);
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
