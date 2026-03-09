import 'package:hive_flutter/hive_flutter.dart';

import '../constants/app_constants.dart';

/// Abstract interface for cache operations.
///
/// Used for storing non-sensitive data that needs to persist offline.
abstract class CacheService {
  Future<void> put<T>(String key, T value);
  Future<T?> get<T>(String key);
  Future<void> delete(String key);
  Future<void> clear();
  Future<bool> containsKey(String key);
}

/// Implementation of [CacheService] using Hive.
class HiveCacheService implements CacheService {
  final Box _box;

  HiveCacheService({required Box box}) : _box = box;

  /// Creates a [HiveCacheService] using the default cache box.
  static Future<HiveCacheService> create() async {
    final box = await Hive.openBox(AppConstants.cacheBoxName);
    return HiveCacheService(box: box);
  }

  @override
  Future<void> put<T>(String key, T value) async {
    await _box.put(key, value);
  }

  @override
  Future<T?> get<T>(String key) async {
    return _box.get(key) as T?;
  }

  @override
  Future<void> delete(String key) async {
    await _box.delete(key);
  }

  @override
  Future<void> clear() async {
    await _box.clear();
  }

  @override
  Future<bool> containsKey(String key) async {
    return _box.containsKey(key);
  }
}

/// Extension for auth-specific cache operations.
extension AuthCache on CacheService {
  Future<void> cacheUserSession(Map<String, dynamic> userData) async {
    await put('user_session', userData);
  }

  Future<Map<String, dynamic>?> getCachedUserSession() async {
    final data = await get<Map>('user_session');
    return data?.cast<String, dynamic>();
  }

  Future<void> clearUserSession() async {
    await delete('user_session');
  }
}
