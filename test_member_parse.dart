import 'package:calcetto_app/features/clubs/data/models/member_model.dart';
import 'package:calcetto_app/features/clubs/domain/entities/club_privilege.dart';

void main() {
  // Test parsing API response
  final apiResponse = {
    'id': '019cf881-0151-799b-bb6d-539e625c824f',
    'userId': '019cf872-a1b8-79a7-980a-a593de0d9379',
    'clubId': '019cf876-2040-774f-99ee-5e6fb09a0e41',
    'name': 'Test User',
    'avatarUrl': null,
    'privilege': 0, // OWNER as int
    'primaryPosition': 2,
    'secondaryPositions': [3],
    'joinedAt': '2026-03-16T21:15:29.990961Z',
    'jerseyNumber': 10,
    'symbol': 'TU',
    'nationality': 'IT'
  };

  try {
    final member = MemberModel.fromJson(apiResponse);
    print('SUCCESS: Parsed member');
    print('  Name: ${member.name}');
    print('  Privilege: ${member.privilege}');
    print('  JoinedAt: ${member.joinedAt}');
  } catch (e) {
    print('ERROR: $e');
  }
}
