import 'package:hive_flutter/hive_flutter.dart';

import '../../features/clubs/data/models/club_model.dart';
import '../../features/clubs/data/models/member_model.dart';

/// Time-to-live for cached clubs data.
///
/// Cached data is considered stale and should be refreshed after this duration.
const Duration clubsCacheTTL = Duration(minutes: 5);

/// Keys for Hive cache storage.
abstract class ClubsCacheKeys {
  /// Cache key for clubs list.
  static const String clubs = 'cached_clubs';

  /// Cache key for clubs timestamp.
  static const String clubsTimestamp = 'cached_clubs_timestamp';

  /// Cache key prefix for members (clubId appended).
  static const String membersPrefix = 'cached_members_';

  /// Cache key prefix for members timestamp.
  static const String membersTimestampPrefix = 'cached_members_timestamp_';
}

/// Abstract interface for local club data operations.
///
/// Provides TTL-based caching for clubs and members data.
abstract class ClubsLocalDataSource {
  /// Caches a list of clubs with current timestamp.
  Future<void> cacheClubs(List<ClubModel> clubs);

  /// Retrieves cached clubs if not expired.
  /// Returns null if cache is empty or expired.
  Future<List<ClubModel>?> getCachedClubs();

  /// Caches members for a specific club.
  Future<void> cacheClubMembers(String clubId, List<MemberModel> members);

  /// Retrieves cached members for a club if not expired.
  Future<List<MemberModel>?> getCachedClubMembers(String clubId);

  /// Clears all cached clubs data.
  Future<void> clearAllCache();
}

/// Hive implementation of ClubsLocalDataSource with TTL support.
class HiveClubsLocalDataSource implements ClubsLocalDataSource {
  final Box _box;

  HiveClubsLocalDataSource({required Box box}) : _box = box;

  /// Creates HiveClubsLocalDataSource with 'clubs' box.
  static Future<HiveClubsLocalDataSource> create() async {
    final box = await Hive.openBox('clubs');
    return HiveClubsLocalDataSource(box: box);
  }

  @override
  Future<void> cacheClubs(List<ClubModel> clubs) async {
    await _box.put(ClubsCacheKeys.clubs, clubs);
    await _box.put(ClubsCacheKeys.clubsTimestamp, DateTime.now());
  }

  @override
  Future<List<ClubModel>?> getCachedClubs() async {
    final timestamp = _box.get(ClubsCacheKeys.clubsTimestamp) as DateTime?;
    if (timestamp == null) {
      return null;
    }

    if (DateTime.now().difference(timestamp) > clubsCacheTTL) {
      // Cache expired
      await _box.delete(ClubsCacheKeys.clubs);
      await _box.delete(ClubsCacheKeys.clubsTimestamp);
      return null;
    }

    final cached = _box.get(ClubsCacheKeys.clubs) as List?;
    if (cached == null) {
      return null;
    }

    return cached.map((e) => e as ClubModel).toList();
  }

  @override
  Future<void> cacheClubMembers(
      String clubId, List<MemberModel> members) async {
    final membersKey = '${ClubsCacheKeys.membersPrefix}$clubId';
    final timestampKey = '${ClubsCacheKeys.membersTimestampPrefix}$clubId';
    await _box.put(membersKey, members);
    await _box.put(timestampKey, DateTime.now());
  }

  @override
  Future<List<MemberModel>?> getCachedClubMembers(String clubId) async {
    final membersKey = '${ClubsCacheKeys.membersPrefix}$clubId';
    final timestampKey = '${ClubsCacheKeys.membersTimestampPrefix}$clubId';

    final timestamp = _box.get(timestampKey) as DateTime?;
    if (timestamp == null) {
      return null;
    }

    if (DateTime.now().difference(timestamp) > clubsCacheTTL) {
      // Cache expired, clean up
      await _box.delete(membersKey);
      await _box.delete(timestampKey);
      return null;
    }

    final cached = _box.get(membersKey) as List?;
    if (cached == null) {
      return null;
    }

    return cached.map((e) => e as MemberModel).toList();
  }

  @override
  Future<void> clearAllCache() async {
    await _box.clear();
  }

  /// Checks if cache entry for key is valid (not expired).
  bool isCacheValid(String key) {
    final timestamp = _box.get('${key}Timestamp') as DateTime?;
    if (timestamp == null) {
      return false;
    }
    return DateTime.now().difference(timestamp) <= clubsCacheTTL;
  }
}
