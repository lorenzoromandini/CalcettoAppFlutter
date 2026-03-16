import 'package:serverpod/serverpod.dart';
import 'package:calcetto_backend_server/src/generated/protocol.dart';

class GoalsEndpoint extends Endpoint {
  /// Get all goals for a match
  Future<List<Goal>> getMatchGoals(
    Session session,
    String matchIdStr,
  ) async {
    final matchId = UuidValue.fromString(matchIdStr);

    return await Goal.db.find(
      session,
      where: (t) => t.matchId.equals(matchId),
    );
  }

  /// Add a goal to a match
  Future<Goal> addGoal(
    Session session,
    String matchIdStr,
    String scorerIdStr,
    String? assisterIdStr,
    bool isOwnGoal,
  ) async {
    final userIdStr = session.authenticationKey;
    if (userIdStr == null) throw Exception('Autenticazione richiesta');

    final matchId = UuidValue.fromString(matchIdStr);
    final scorerId = UuidValue.fromString(scorerIdStr);

    UuidValue? assisterId;
    if (assisterIdStr != null) {
      assisterId = UuidValue.fromString(assisterIdStr);
    }

    // Check permissions
    final match = await Match.db.findById(session, matchId);
    if (match == null) throw Exception('Match non trovato');

    final userId = UuidValue.fromString(userIdStr);
    final member = await ClubMember.db.findFirstRow(
      session,
      where: (t) => t.clubId.equals(match.clubId) & t.userId.equals(userId),
    );

    if (member == null || member.privilege == ClubPrivilege.MEMBER) {
      throw Exception('Permessi insufficienti');
    }

    final goal = Goal(
      matchId: matchId,
      scorerId: scorerId,
      assisterId: assisterId,
      isOwnGoal: isOwnGoal,
      createdAt: DateTime.now(),
    );

    return await Goal.db.insertRow(session, goal);
  }

  /// Remove a goal
  Future<void> removeGoal(
    Session session,
    String goalIdStr,
  ) async {
    final userIdStr = session.authenticationKey;
    if (userIdStr == null) throw Exception('Autenticazione richiesta');

    final goalId = UuidValue.fromString(goalIdStr);

    final goal = await Goal.db.findById(session, goalId);
    if (goal == null) throw Exception('Goal non trovato');

    // Check permissions
    final match = await Match.db.findById(session, goal.matchId);
    if (match == null) throw Exception('Match non trovato');

    final userId = UuidValue.fromString(userIdStr);
    final member = await ClubMember.db.findFirstRow(
      session,
      where: (t) => t.clubId.equals(match.clubId) & t.userId.equals(userId),
    );

    if (member == null || member.privilege == ClubPrivilege.MEMBER) {
      throw Exception('Permessi insufficienti');
    }

    await Goal.db.deleteRow(session, goal);
  }

  /// Get player goal statistics
  Future<Map<String, dynamic>> getPlayerStats(
    Session session,
    String clubMemberIdStr,
  ) async {
    final clubMemberId = UuidValue.fromString(clubMemberIdStr);

    final goalsScored = await Goal.db.count(
      session,
      where: (t) => t.scorerId.equals(clubMemberId) & t.isOwnGoal.equals(false),
    );

    final ownGoals = await Goal.db.count(
      session,
      where: (t) => t.scorerId.equals(clubMemberId) & t.isOwnGoal.equals(true),
    );

    final assists = await Goal.db.count(
      session,
      where: (t) => t.assisterId.equals(clubMemberId),
    );

    return {
      'goalsScored': goalsScored,
      'ownGoals': ownGoals,
      'assists': assists,
    };
  }
}
