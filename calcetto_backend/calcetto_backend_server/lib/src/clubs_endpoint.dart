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

  Future<List<Map<String, dynamic>>> getClubs(Session session) async {
    final userIdStr = _extractUserIdFromToken(session.authenticationKey);
    if (userIdStr == null) {
      print('getClubs: userId null');
      return [];
    }

    print('getClubs: userId=$userIdStr');

    final userId = UuidValue.fromString(userIdStr);

    final memberships = await ClubMember.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );

    print('getClubs: found ${memberships.length} memberships');

    if (memberships.isEmpty) return [];

    final result = <Map<String, dynamic>>[];

    for (var membership in memberships) {
      final club = await Club.db.findById(session, membership.clubId);
      if (club != null) {
        // Count members
        final memberCount = await ClubMember.db.count(
          session,
          where: (t) => t.clubId.equals(club.id!),
        );

        result.add({
          'id': club.id?.toString(),
          'name': club.name,
          'description': club.description,
          'imageUrl': club.imageUrl,
          'createdBy': club.createdBy?.toString(),
          'createdAt': club.createdAt?.toIso8601String(),
          'updatedAt': club.updatedAt?.toIso8601String(),
          'memberCount': memberCount,
          'privilege':
              membership.privilege.index, // 0=OWNER, 1=MANAGER, 2=MEMBER
        });
      }
    }

    print('getClubs: returning ${result.length} clubs');
    return result;
  }

  Future<Map<String, dynamic>?> getClubById(Session session, String? id) async {
    if (id == null) return null;

    final userIdStr = _extractUserIdFromToken(session.authenticationKey);
    if (userIdStr == null) return null;

    final clubId = UuidValue.fromString(id);
    final userId = UuidValue.fromString(userIdStr);

    final club = await Club.db.findById(session, clubId);
    if (club == null) return null;

    // Get user's membership to determine privilege
    final membership = await ClubMember.db.findFirstRow(
      session,
      where: (t) => t.clubId.equals(clubId) & t.userId.equals(userId),
    );

    // Count members
    final memberCount = await ClubMember.db.count(
      session,
      where: (t) => t.clubId.equals(clubId),
    );

    return {
      'id': club.id?.toString(),
      'name': club.name,
      'description': club.description,
      'imageUrl': club.imageUrl,
      'createdBy': club.createdBy?.toString(),
      'createdAt': club.createdAt?.toIso8601String(),
      'updatedAt': club.updatedAt?.toIso8601String(),
      'memberCount': memberCount,
      'privilege': membership?.privilege.index ??
          2, // Default to MEMBER (2) if not found
    };
  }

  Future<List<Map<String, dynamic>>> getClubMembers(
      Session session, String? clubIdStr) async {
    print('getClubMembers: called with clubIdStr=$clubIdStr');
    if (clubIdStr == null) {
      print('getClubMembers: clubIdStr is null, returning empty');
      return [];
    }

    try {
      final clubId = UuidValue.fromString(clubIdStr);
      print('getClubMembers: parsed clubId=$clubId');

      final memberships = await ClubMember.db.find(
        session,
        where: (t) => t.clubId.equals(clubId),
      );

      print('getClubMembers: found ${memberships.length} memberships');

      // Enrich with user data
      final result = <Map<String, dynamic>>[];
      for (var membership in memberships) {
        print(
            'getClubMembers: processing membership for userId=${membership.userId}');
        final user = await User.db.findById(session, membership.userId);
        if (user != null) {
          print('getClubMembers: found user ${user.email}');
          result.add({
            'id': membership.id?.toString(),
            'userId': membership.userId.toString(),
            'clubId': membership.clubId.toString(),
            'name': '${user.firstName} ${user.lastName}',
            'avatarUrl': user.imageUrl,
            'privilege':
                membership.privilege.index, // 0=OWNER, 1=MANAGER, 2=MEMBER
            'primaryPosition':
                membership.primaryRole.index, // 0=GK, 1=DEF, 2=MID, 3=ST
            'secondaryPositions':
                membership.secondaryRoles.map((p) => p.index).toList(),
            'joinedAt': membership.joinedAt?.toIso8601String(),
            'jerseyNumber': membership.jerseyNumber,
            'symbol': membership.symbol,
            'nationality': membership.nationality,
          });
        } else {
          print(
              'getClubMembers: user not found for userId=${membership.userId}');
        }
      }

      print('getClubMembers: returning ${result.length} members');
      return result;
    } catch (e, stack) {
      print('getClubMembers: ERROR $e');
      print('getClubMembers: STACK $stack');
      return [];
    }
  }

  Future<Map<String, dynamic>> generateInviteCode(
      Session session, String? clubIdStr) async {
    if (clubIdStr == null) throw Exception('Club ID non valido');

    final userIdStr = _extractUserIdFromToken(session.authenticationKey);
    if (userIdStr == null) throw Exception('Permessi insufficienti');

    final clubId = UuidValue.fromString(clubIdStr);
    final userId = UuidValue.fromString(userIdStr);

    final member = await ClubMember.db.findFirstRow(
      session,
      where: (t) => t.clubId.equals(clubId) & t.userId.equals(userId),
    );

    if (member == null) throw Exception('Non sei membro');

    // Check if user has permission (OWNER or MANAGER)
    if (member.privilege == ClubPrivilege.MEMBER) {
      throw Exception('Permessi insufficienti');
    }

    return {
      'code': 'INV_${clubIdStr}_${DateTime.now().millisecondsSinceEpoch}',
      'clubId': clubIdStr
    };
  }

  Future<void> deleteClub(Session session, String? clubIdStr) async {
    if (clubIdStr == null) throw Exception('Club ID non valido');

    final userIdStr = _extractUserIdFromToken(session.authenticationKey);
    if (userIdStr == null) throw Exception('Permessi insufficienti');

    final clubId = UuidValue.fromString(clubIdStr);
    final userId = UuidValue.fromString(userIdStr);

    final member = await ClubMember.db.findFirstRow(
      session,
      where: (t) => t.clubId.equals(clubId) & t.userId.equals(userId),
    );

    if (member == null || member.privilege != ClubPrivilege.OWNER) {
      throw Exception('Solo il proprietario può eliminare il club');
    }

    // Soft delete by setting deletedAt
    final club = await Club.db.findById(session, clubId);
    if (club != null) {
      club.deletedAt = DateTime.now();
      await Club.db.updateRow(session, club);
    }
  }

  Future<Club> createClub(
    Session session,
    String name,
    String? description,
    String? imageUrl,
  ) async {
    final userIdStr = _extractUserIdFromToken(session.authenticationKey);
    if (userIdStr == null) throw Exception('Autenticazione richiesta');

    final userId = UuidValue.fromString(userIdStr);

    final club = Club(
      name: name,
      description: description,
      imageUrl: imageUrl,
      createdBy: userId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final createdClub = await Club.db.insertRow(session, club);

    // Create membership as OWNER
    final membership = ClubMember(
      clubId: createdClub.id!,
      userId: userId,
      privilege: ClubPrivilege.OWNER,
      primaryRole: PlayerPosition.MID,
      secondaryRoles: [],
      joinedAt: DateTime.now(),
    );

    await ClubMember.db.insertRow(session, membership);

    return createdClub;
  }
}
