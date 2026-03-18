import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/club.dart';

/// Provider for fetching deleted clubs.
///
/// Returns clubs that have been soft-deleted within the last 30 days
/// where the user is an owner or manager.
final deletedClubsProvider =
    FutureProvider.autoDispose<List<Club>>((ref) async {
  final repository = ref.watch(clubsRepositoryProvider);
  final result = await repository.getDeletedClubs();

  return result.fold(
    (failure) => throw failure,
    (clubs) => clubs,
  );
});

/// Provider for recovering a deleted club.
///
/// Takes the club ID and returns the recovered club.
final recoverClubProvider =
    FutureProvider.autoDispose.family<Club, String>((ref, clubId) async {
  final repository = ref.watch(clubsRepositoryProvider);
  final result = await repository.recoverClub(clubId);

  return result.fold(
    (failure) => throw failure,
    (club) => club,
  );
});
