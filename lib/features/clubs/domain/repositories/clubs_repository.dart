import '../entities/club.dart';
import '../entities/member.dart';
import '../../../../core/utils/result.dart';

/// Abstract repository interface for club operations.
///
/// Defines the contract for club data operations, implemented by
/// infrastructure layer with network awareness and caching.
///
/// All methods return Result<T> where Failure is embedded in FailureResult variant.
abstract class ClubsRepository {
  /// Fetches list of clubs the user belongs to.
  ///
  /// Returns cached data when offline, fresh data when online.
  Future<Result<List<Club>>> getClubs();

  /// Fetches a single club by ID.
  ///
  /// Checks cache first, fetches remote if stale/missing and online.
  /// Returns null if club is deleted or not found.
  Future<Result<Club?>> getClubById(String id);

  /// Fetches members of a specific club.
  ///
  /// Returns cached members when offline, fetches when online.
  Future<Result<List<Member>>> getClubMembers(String clubId);

  /// Generates an invite code for a club (admin only).
  ///
  /// Requires network connection - returns NetworkFailure when offline.
  Future<Result<String>> generateInviteCode(String clubId);

  /// Deletes a club (owner only).
  ///
  /// Requires owner privileges and network connection.
  /// Returns error if user is not owner or club has other members.
  Future<Result<void>> deleteClub(String clubId);

  /// Creates a new club (owner becomes the creator).
  ///
  /// Requires network connection.
  /// Returns the created club with generated ID.
  Future<Result<Club>> createClub({
    required String name,
    String? description,
  });

  /// Join a club using an invite code.
  ///
  /// Validates the code and adds user as a member.
  /// Returns the joined club.
  Future<Result<Club>> joinClub(String inviteCode);

  /// Get deleted clubs for recovery.
  ///
  /// Returns clubs that have been soft-deleted within the last 30 days
  /// where the user is an owner or manager.
  Future<Result<List<Club>>> getDeletedClubs();

  /// Recover a deleted club.
  ///
  /// Clears the deletedAt timestamp to restore the club.
  /// Only owner or manager can recover.
  Future<Result<Club>> recoverClub(String clubId);
}
