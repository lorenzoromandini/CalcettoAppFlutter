import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calcetto_app/features/clubs/domain/entities/member.dart';
import 'package:calcetto_app/features/clubs/domain/entities/club_privilege.dart';
import 'package:calcetto_app/features/clubs/domain/repositories/clubs_repository.dart';
import 'package:calcetto_app/core/di/injection.dart';

/// Riverpod provider for fetching and caching club members.
///
/// Family provider that takes a clubId and returns a list of members.
/// Implements caching with automatic refresh.
final clubMembersProvider =
    FutureProvider.family<List<Member>, String>((ref, clubId) async {
  final repository = ref.watch(clubsRepositoryProvider);

  final result = await repository.getClubMembers(clubId);

  return result.fold(
    (error) {
      throw Exception('Failed to load members: $error');
    },
    (members) {
      return _sortMembers(members);
    },
  );
});

/// Sorts members by privilege hierarchy, then by name.
///
/// Order:
/// 1. Owners first
/// 2. Managers second
/// 3. Members last
/// Within each privilege: alphabetical by name
List<Member> _sortMembers(List<Member> members) {
  final sorted = List<Member>.from(members);

  sorted.sort((a, b) {
    // First sort by privilege
    final privilegeComparison = _comparePrivileges(a.privilege, b.privilege);
    if (privilegeComparison != 0) {
      return privilegeComparison;
    }

    // Then by name
    return a.name.compareTo(b.name);
  });

  return sorted;
}

/// Compares two privileges for sorting.
///
/// Returns negative if privilegeA comes before privilegeB,
/// positive if privilegeA comes after privilegeB,
/// zero if equal.
int _comparePrivileges(ClubPrivilege privilegeA, ClubPrivilege privilegeB) {
  const rank = {
    ClubPrivilege.OWNER: 1,
    ClubPrivilege.MANAGER: 2,
    ClubPrivilege.MEMBER: 3,
  };

  return rank[privilegeA]!.compareTo(rank[privilegeB]!);
}
