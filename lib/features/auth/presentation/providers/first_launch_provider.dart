import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/services/cache_service.dart';

/// Provider for first launch detection state.
final firstLaunchProvider =
    StateNotifierProvider<FirstLaunchNotifier, bool>((ref) {
  return FirstLaunchNotifier(ref.watch(cacheServiceProvider));
});

/// Notifier for managing first launch state.
///
/// Tracks whether the user has seen the welcome screen.
/// Persists preference to cache.
class FirstLaunchNotifier extends StateNotifier<bool> {
  final CacheService _cacheService;
  static const String _hasSeenWelcomeKey = 'has_seen_welcome';

  FirstLaunchNotifier(this._cacheService) : super(false) {
    _checkFirstLaunch();
  }

  /// Check if this is first launch (welcome not shown).
  Future<void> _checkFirstLaunch() async {
    try {
      final hasSeenWelcome = await _cacheService.get<bool>(_hasSeenWelcomeKey);
      state = hasSeenWelcome != true; // true if null or false
    } catch (e) {
      // Default to first launch if cache check fails
      state = true;
    }
  }

  /// Mark welcome as seen and persist to cache.
  Future<void> markWelcomeSeen() async {
    state = false;
    try {
      await _cacheService.put(_hasSeenWelcomeKey, true);
    } catch (e) {
      // Ignore cache errors - state still updated in memory
    }
  }
}
