import 'dart:convert';
import 'package:serverpod/serverpod.dart';
import 'package:calcetto_backend_server/src/generated/protocol.dart';

/// Endpoint for club operations
class ClubsEndpoint extends Endpoint {
  int? _extractUserIdFromToken(String? authHeader) {
    if (authHeader == null || !authHeader.startsWith('Bearer ')) {
      return null;
    }
    try {
      final token = authHeader.substring(7);
      // Token is base64-encoded JSON (not standard JWT format)
      var payload = token;
      // Add base64 padding
      while (payload.length % 4 != 0) {
        payload += '=';
      }
      final decoded = utf8.decode(base64Url.decode(payload));
      final json = jsonDecode(decoded) as Map<String, dynamic>;
      return json['user_id'] as int?;
    } catch (e) {
      print('ERROR extracting userId: $e');
    }
    return null;
  }

  /// Get all clubs for the authenticated user
  Future<List<Club>> getClubs(Session session) async {
    print('DEBUG: authKey = ${session.authenticationKey}');
    final userId = _extractUserIdFromToken(session.authenticationKey);
    print('DEBUG: extracted userId = $userId');

    if (userId == null || userId <= 0) {
      return [];
    }

    final memberships = await ClubMember.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );

    if (memberships.isEmpty) {
      return [];
    }

    final clubIds = memberships.map((m) => m.clubId).toList();
    final clubs = <Club>[];
    for (var clubId in clubIds) {
      final club = await Club.db.findById(session, clubId);
      if (club != null) {
        clubs.add(club);
      }
    }

    return clubs;
  }

  /// Create a new club
  Future<Club> createClub(
    Session session,
    String name,
    String? description,
    String? imageUrl,
  ) async {
    final userId = _extractUserIdFromToken(session.authenticationKey);

    if (userId == null || userId <= 0) {
      throw Exception('Permessi insufficienti');
    }

    final club = Club(
      name: name,
      description: description,
      imageUrl: imageUrl,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final createdClub = await Club.db.insertRow(session, club);

    // Add creator as OWNER
    await ClubMember.db.insertRow(
      session,
      ClubMember(
        clubId: createdClub.id!,
        userId: userId,
        privileges: 2, // owner
        joinedAt: DateTime.now(),
      ),
    );

    return createdClub;
  }
}
