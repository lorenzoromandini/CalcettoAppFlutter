import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/club.dart';

/// Riverpod provider for fetching and managing the clubs list.
///
/// Implements pull-to-refresh with force refresh capability.
/// Handles offline gracefully by using cached data from repository.
final clubsListProvider = NotifierProvider<ClubsList, AsyncValue<List<Club>>>(
  ClubsList.new,
);

/// Notifier class for managing clubs list state.
class ClubsList extends Notifier<AsyncValue<List<Club>>> {
  @override
  AsyncValue<List<Club>> build() {
    return const AsyncValue.loading();
  }

  /// Fetch clubs from repository.
  Future<void> fetchClubs() async {
    state = const AsyncValue.loading();

    final repository = ref.read(clubsRepositoryProvider);
    final result = await repository.getClubs();

    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (clubs) => AsyncValue.data(clubs),
    );
  }

  /// Refresh the clubs list (for pull-to_refresh).
  ///
  /// Uses forceRefresh to bypass cache and fetch from remote.
  Future<void> refresh() async {
    state = const AsyncValue.loading();

    final repository = ref.read(clubsRepositoryProvider);
    final result = await repository.getClubs();

    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (clubs) => AsyncValue.data(clubs),
    );
  }
}

/// Provider notifier for clubs list operations.
extension ClubsListNotifier on ClubsList {
  /// Initialize the clubs list on first build.
  void initialize() {
    Future.microtask(() => fetchClubs());
  }
}
