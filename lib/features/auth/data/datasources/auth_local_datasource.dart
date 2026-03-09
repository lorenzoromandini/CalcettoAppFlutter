import '../../../../core/services/cache_service.dart';
import '../models/user_model.dart';

/// Abstract interface for local authentication data operations.
abstract class AuthLocalDataSource {
  /// Caches user data locally for offline access.
  Future<void> cacheUser(UserModel user);

  /// Retrieves cached user data.
  Future<UserModel?> getCachedUser();

  /// Clears cached user data.
  Future<void> clearCache();
}

/// Implementation of [AuthLocalDataSource] using Hive cache.
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final CacheService _cacheService;

  AuthLocalDataSourceImpl({required CacheService cacheService})
      : _cacheService = cacheService;

  @override
  Future<void> cacheUser(UserModel user) async {
    await _cacheService.put('cached_user', user.toJson());
  }

  @override
  Future<UserModel?> getCachedUser() async {
    final data = await _cacheService.get<Map>('cached_user');
    if (data != null) {
      return UserModel.fromJson(data.cast<String, dynamic>());
    }
    return null;
  }

  @override
  Future<void> clearCache() async {
    await _cacheService.delete('cached_user');
  }
}
