import 'package:serverpod/serverpod.dart';
import 'package:calcetto_backend_server/src/generated/protocol.dart';

class MatchesEndpoint extends Endpoint {
  /// Get all matches for a club
  Future<List<Match>> getClubMatches(
    Session session,
    String clubIdStr, {
    String? status,
  }) async {
    final clubId = UuidValue.fromString(clubIdStr);

    var query = Match.db.find(
      session,
      where: (t) => t.clubId.equals(clubId),
    );

    if (status != null) {
      final matchStatus = MatchStatus.values.firstWhere(
        (s) => s.name == status,
        orElse: () => MatchStatus.scheduled,
      );
      query = Match.db.find(
        session,
        where: (t) => t.clubId.equals(clubId) & t.status.equals(matchStatus),
      );
    }

    return await query;
  }

  /// Get match by ID
  Future<Match?> getMatchById(Session session, String matchIdStr) async {
    final matchId = UuidValue.fromString(matchIdStr);
    return await Match.db.findById(session, matchId);
  }

  /// Create a new match
  Future<Match> createMatch(
    Session session,
    String clubIdStr,
    DateTime scheduledAt,
    String? location,
    String modeStr,
  ) async {
    final userIdStr = session.authenticationKey;
    if (userIdStr == null) throw Exception('Autenticazione richiesta');

    final clubId = UuidValue.fromString(clubIdStr);
    final userId = UuidValue.fromString(userIdStr);

    // Check if user can create matches (OWNER or MANAGER)
    final member = await ClubMember.db.findFirstRow(
      session,
      where: (t) => t.clubId.equals(clubId) & t.userId.equals(userId),
    );

    if (member == null || member.privilege == ClubPrivilege.MEMBER) {
      throw Exception('Permessi insufficienti');
    }

    final mode = MatchMode.values.firstWhere(
      (m) => m.name == modeStr,
      orElse: () => MatchMode.fiveVsFive,
    );

    final match = Match(
      clubId: clubId,
      scheduledAt: scheduledAt,
      location: location,
      mode: mode,
      status: MatchStatus.scheduled,
      homeScore: 0,
      awayScore: 0,
      createdBy: userId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    return await Match.db.insertRow(session, match);
  }

  /// Update match status
  Future<Match> updateMatchStatus(
    Session session,
    String matchIdStr,
    String statusStr,
  ) async {
    final matchId = UuidValue.fromString(matchIdStr);

    final match = await Match.db.findById(session, matchId);
    if (match == null) throw Exception('Match non trovato');

    final status = MatchStatus.values.firstWhere(
      (s) => s.name == statusStr,
      orElse: () => MatchStatus.scheduled,
    );

    match.status = status;
    match.updatedAt = DateTime.now();

    return await Match.db.updateRow(session, match);
  }

  /// Update match score
  Future<Match> updateScore(
    Session session,
    String matchIdStr,
    int homeScore,
    int awayScore,
  ) async {
    final userIdStr = session.authenticationKey;
    if (userIdStr == null) throw Exception('Autenticazione richiesta');

    final matchId = UuidValue.fromString(matchIdStr);
    final userId = UuidValue.fromString(userIdStr);

    final match = await Match.db.findById(session, matchId);
    if (match == null) throw Exception('Match non trovato');

    // Check permissions
    final member = await ClubMember.db.findFirstRow(
      session,
      where: (t) => t.clubId.equals(match.clubId) & t.userId.equals(userId),
    );

    if (member == null || member.privilege == ClubPrivilege.MEMBER) {
      throw Exception('Permessi insufficienti');
    }

    match.homeScore = homeScore;
    match.awayScore = awayScore;
    match.updatedAt = DateTime.now();

    return await Match.db.updateRow(session, match);
  }

  /// Get match participants
  Future<List<MatchParticipant>> getMatchParticipants(
    Session session,
    String matchIdStr,
  ) async {
    final matchId = UuidValue.fromString(matchIdStr);

    return await MatchParticipant.db.find(
      session,
      where: (t) => t.matchId.equals(matchId),
    );
  }

  /// Add participant to match
  Future<MatchParticipant> addParticipant(
    Session session,
    String matchIdStr,
    String clubMemberIdStr,
    String teamSideStr,
    String? positionStr,
  ) async {
    final matchId = UuidValue.fromString(matchIdStr);
    final clubMemberId = UuidValue.fromString(clubMemberIdStr);

    final teamSide = MatchTeamSide.values.firstWhere(
      (t) => t.name == teamSideStr,
      orElse: () => MatchTeamSide.home,
    );

    PlayerPosition? position;
    if (positionStr != null) {
      position = PlayerPosition.values.firstWhere(
        (p) => p.name == positionStr,
        orElse: () => PlayerPosition.MID,
      );
    }

    final participant = MatchParticipant(
      matchId: matchId,
      clubMemberId: clubMemberId,
      teamSide: teamSide,
      position: position,
    );

    return await MatchParticipant.db.insertRow(session, participant);
  }

  /// Remove participant from match
  Future<void> removeParticipant(
    Session session,
    String participantIdStr,
  ) async {
    final participantId = UuidValue.fromString(participantIdStr);

    final participant =
        await MatchParticipant.db.findById(session, participantId);
    if (participant != null) {
      await MatchParticipant.db.deleteRow(session, participant);
    }
  }
}
