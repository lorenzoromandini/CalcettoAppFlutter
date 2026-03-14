import 'dart:convert';
import 'package:serverpod/serverpod.dart';
import 'package:calcetto_backend_server/src/generated/protocol.dart';

class ClubsEndpoint extends Endpoint {
  String? _extractUserIdFromToken(String? authHeader) {
    if (authHeader == null || !authHeader.startsWith('Bearer ')) return null;
    
    try {
      final token = authHeader.substring(7);
      var payload = token;
      while (payload.length % 4 != 0) payload += '=';
      
      final decoded = utf8.decode(base64Url.decode(payload));
      final json = jsonDecode(decoded) as Map<String, dynamic>;
      
      return json['user_id']?.toString();
    } catch (e) {
      print('ERROR: $e');
    }
    return null;
  }

  Future<List<Club>> getClubs(Session session) async {
    final userId = _extractUserIdFromToken(session.authenticationKey);
    if (userId == null) {
      print('getClubs: userId null');
      return [];
    }

    print('getClubs: userId=$userId');
    
    final memberships = await ClubMember.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );

    print('getClubs: found ${memberships.length} memberships');

    if (memberships.isEmpty) return [];

    final clubIds = memberships.map((m) => m.clubId).toSet().toList();
    final clubs = <Club>[];
    
    for (var clubId in clubIds) {
      final club = await Club.db.findById(session, clubId);
      if (club != null) clubs.add(club);
    }

    print('getClubs: returning ${clubs.length} clubs');
    return clubs;
  }

  Future<Club?> getClubById(Session session, int? id) async {
    if (id == null) return null;
    return await Club.db.findById(session, id);
  }

  Future<List<ClubMember>> getClubMembers(Session session, int? clubId) async {
    if (clubId == null) return [];
    
    return await ClubMember.db.find(
      session,
      where: (t) => t.clubId.equals(clubId),
    );
  }

  Future<Map<String, dynamic>> generateInviteCode(Session session, int? clubId) async {
    if (clubId == null) throw Exception('Club ID non valido');

    final userId = _extractUserIdFromToken(session.authenticationKey);
    if (userId == null) throw Exception('Permessi insufficienti');

    final member = await ClubMember.db.findFirstRow(
      session,
      where: (t) => t.clubId.equals(clubId) & t.userId.equals(userId),
    );

    if (member == null) throw Exception('Non sei membro');

    return {'code': 'INV_${clubId}_${DateTime.now().millisecondsSinceEpoch}', 'clubId': clubId};
  }
}
