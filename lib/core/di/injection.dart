import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/app_constants.dart';
import '../services/cache_service.dart';
import '../services/secure_storage_service.dart';

/// Provider for flutter_secure_storage instance.
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
