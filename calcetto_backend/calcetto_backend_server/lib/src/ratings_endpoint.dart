import 'package:serverpod/serverpod.dart';
import 'package:calcetto_backend_server/src/generated/protocol.dart';

class RatingsEndpoint extends Endpoint {
  /// Get all ratings for a match
  Future<List<PlayerRating>> getMatchRatings(
    Session session,
    String matchIdStr,
  ) async {
    final matchId = UuidValue.fromString(matchIdStr);

    return await PlayerRating.db.find(
      session,
      where: (t) => t.matchId.equals(matchId),
    );
  }

  /// Get rating for a specific player in a match
  Future<PlayerRating?> getPlayerRating(
    Session session,
    String matchIdStr,
    String clubMemberIdStr,
  ) async {
    final matchId = UuidValue.fromString(matchIdStr);
    final clubMemberId = UuidValue.fromString(clubMemberIdStr);

    return await PlayerRating.db.findFirstRow(
      session,
      where: (t) =>
          t.matchId.equals(matchId) & t.clubMemberId.equals(clubMemberId),
    );
  }

  /// Add or update a player rating
  Future<PlayerRating> ratePlayer(
    Session session,
    String matchIdStr,
    String clubMemberIdStr,
    double rating,
    String? comment,
  ) async {
    final userIdStr = session.authenticationKey;
    if (userIdStr == null) throw Exception('Autenticazione richiesta');

    final matchId = UuidValue.fromString(matchIdStr);
    final clubMemberId = UuidValue.fromString(clubMemberIdStr);
    final userId = UuidValue.fromString(userIdStr);

    // Validate rating range
    if (rating < 1.0 || rating > 10.0) {
      throw Exception('Rating deve essere tra 1.0 e 10.0');
    }

    // Check permissions
    final match = await Match.db.findById(session, matchId);
    if (match == null) throw Exception('Match non trovato');

    final member = await ClubMember.db.findFirstRow(
      session,
      where: (t) => t.clubId.equals(match.clubId) & t.userId.equals(userId),
    );

    if (member == null || member.privilege == ClubPrivilege.MEMBER) {
      throw Exception('Permessi insufficienti');
    }

    // Check if rating already exists
    final existingRating = await PlayerRating.db.findFirstRow(
      session,
      where: (t) =>
          t.matchId.equals(matchId) & t.clubMemberId.equals(clubMemberId),
    );

    if (existingRating != null) {
      // Update existing rating
      existingRating.rating = rating;
      existingRating.comment = comment;
      existingRating.updatedAt = DateTime.now();
      return await PlayerRating.db.updateRow(session, existingRating);
    } else {
      // Create new rating
      final playerRating = PlayerRating(
        matchId: matchId,
        clubMemberId: clubMemberId,
        rating: rating,
        comment: comment,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      return await PlayerRating.db.insertRow(session, playerRating);
    }
  }

  /// Get average rating for a player across all matches
  Future<Map<String, dynamic>> getPlayerAverageRating(
    Session session,
    String clubMemberIdStr,
  ) async {
    final clubMemberId = UuidValue.fromString(clubMemberIdStr);

    final ratings = await PlayerRating.db.find(
      session,
      where: (t) => t.clubMemberId.equals(clubMemberId),
    );

    if (ratings.isEmpty) {
      return {
        'averageRating': 0.0,
        'totalRatings': 0,
      };
    }

    final sum = ratings.fold(0.0, (acc, r) => acc + r.rating);
    final average = sum / ratings.length;

    return {
      'averageRating': double.parse(average.toStringAsFixed(2)),
      'totalRatings': ratings.length,
    };
  }

  /// Get all ratings given by a user
  Future<List<PlayerRating>> getRatingsByUser(
    Session session,
  ) async {
    final userIdStr = session.authenticationKey;
    if (userIdStr == null) throw Exception('Autenticazione richiesta');

    // This would require tracking who gave the rating
    // For now, return all ratings for matches in user's clubs
    final userId = UuidValue.fromString(userIdStr);

    final memberships = await ClubMember.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );

    final clubIds = memberships.map((m) => m.clubId).toSet().toList();

    final allRatings = <PlayerRating>[];
    for (final clubId in clubIds) {
      final matches = await Match.db.find(
        session,
        where: (t) => t.clubId.equals(clubId),
      );

      for (final match in matches) {
        final ratings = await PlayerRating.db.find(
          session,
          where: (t) => t.matchId.equals(match.id!),
        );
        allRatings.addAll(ratings);
      }
    }

    return allRatings;
  }
}
