import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/injection.dart';
import '../../data/repositories/clubs_repository_impl.dart';
import '../../domain/entities/club.dart';

/// Provider for the currently active club.
///
/// Persists the selected club ID to Hive cache.
/// Automatically fetches full club data when club is selected.
final activeClubProvider = NotifierProvider<ActiveClub, AsyncValue<Club?>>(
  ActiveClub.new,
);

/// Key for storing active club ID in Hive.
const String _activeClubIdKey = 'active_club_id';

/// Notifier class for managing active club state.
class ActiveClub extends Notifier<AsyncValue<Club?>> {
  @override
  AsyncValue<Club?> build() {
    return const AsyncValue.loading();
  }

  /// Initialize active club from cache.
  Future<void> initialize() async {
    final box = ref.read(cacheBoxProvider);
    final cachedId = box.get(_activeClubIdKey) as String?;

    if (cachedId == null) {
      state = const AsyncValue.data(null);
      return;
    }

    await _fetchClub(cachedId);
  }

  /// Set the active club by ID.
  ///
  /// Persists to Hive and fetches full club data.
  /// Resets navigation to home tab after selection.
  Future<void> setActiveClub(String clubId) async {
    state = const AsyncValue.loading();

    // Save to Hive
    final box = ref.read(cacheBoxProvider);
    await box.put(_activeClubIdKey, clubId);

    // Fetch full club data
    await _fetchClub(clubId);

    // Reset navigation to home tab
    // Note: navigationProvider would be imported from core/navigation
    // ref.read(navigationProvider.notifier).setTab(0);
  }

  /// Clear the active club selection.
  Future<void> clearActiveClub() async {
    final box = ref.read(cacheBoxProvider);
    await box.delete(_activeClubIdKey);
    state = const AsyncValue.data(null);
  }

  /// Check if a club is the active one.
  bool isActive(Club club) {
    final currentState = state.value;
    if (currentState == null) {
      return false;
    }
    return club.id == currentState.id;
  }

  /// Helper method to fetch club by ID.
  Future<void> _fetchClub(String clubId) async {
    final repository = ref.read(clubsRepositoryProvider);
    final result = await repository.getClubById(clubId);

    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (club) => AsyncValue.data(club),
    );
  }
}
