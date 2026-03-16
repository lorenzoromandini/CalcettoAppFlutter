import 'package:flutter/material.dart';
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
      (clubs) {
        // Auto-set first club as active if none is set
        if (clubs.isNotEmpty) {
          final activeClub = ref.read(activeClubProvider);
          if (activeClub.value == null) {
            // No active club set, set the first one
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ref
                  .read(activeClubProvider.notifier)
                  .setActiveClub(clubs.first.id);
            });
          }
        }
        return AsyncValue.data(clubs);
      },
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

  /// Create a new club.
  Future<void> createClub({
    required String name,
    String? description,
  }) async {
    final repository = ref.read(clubsRepositoryProvider);
    final result = await repository.createClub(
      name: name,
      description: description,
    );

    result.fold(
      (failure) => throw Exception('Failed to create club: $failure'),
      (club) async {
        // Refresh the list to include the new club
        await refresh();
        // Set the new club as active
        await ref.read(activeClubProvider.notifier).setActiveClub(club.id);
      },
    );
  }

  /// Delete a club.
  Future<void> deleteClub(String clubId) async {
    final repository = ref.read(clubsRepositoryProvider);
    final result = await repository.deleteClub(clubId);

    result.fold(
      (failure) => throw Exception('Failed to delete club: $failure'),
      (_) async {
        // Clear active club if it was the deleted one
        final activeClub = ref.read(activeClubProvider).value;
        if (activeClub?.id == clubId) {
          await ref.read(activeClubProvider.notifier).clearActiveClub();
        }
        // Refresh the list
        await refresh();
      },
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
