import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calcetto_app/features/clubs/domain/entities/club.dart';
import 'package:calcetto_app/features/clubs/domain/repositories/clubs_repository.dart';
import 'package:calcetto_app/core/di/injection.dart';

/// Riverpod provider for invite code generation.
///
/// Admin-only feature (OWNER or MANAGER roles).
/// Generates one-time use invite codes that never expire.
final inviteCodeProvider =
    StateNotifierProvider<InviteCodeNotifier, AsyncValue<String?>>((ref) {
  return InviteCodeNotifier(ref.watch(clubsRepositoryProvider));
});

/// State notifier for invite code generation.
class InviteCodeNotifier extends StateNotifier<AsyncValue<String?>> {
  final ClubsRepository _repository;

  InviteCodeNotifier(this._repository) : super(const AsyncValue.data(null));

  /// Generates an invite code for the specified club.
  ///
  /// Only users with OWNER or MANAGER role can generate codes.
  /// Returns one-time use code (8-char alphanumeric).
  Future<void> generate(String clubId, ClubRole userRole) async {
    // Check admin permission
    if (!userRole.isAdmin) {
      state = AsyncValue.data(null);
      return;
    }

    state = const AsyncValue.loading();

    try {
      final result = await _repository.generateInviteCode(clubId);

      state = result.fold(
        (error) => AsyncValue.error(error, StackTrace.current),
        (code) => AsyncValue.data(code),
      );
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }

  /// Clears the current invite code.
  void clear() {
    state = const AsyncValue.data(null);
  }
}
