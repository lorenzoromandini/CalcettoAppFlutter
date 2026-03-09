import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calcetto_app/features/clubs/domain/entities/member.dart';
import 'package:calcetto_app/features/clubs/domain/entities/club.dart';
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
    (error) => throw Exception('Failed to load members: $error'),
    (members) => _sortMembers(members),
  );
});

/// Sorts members by role hierarchy, then by name.
///
/// Order:
/// 1. Owners first
/// 2. Managers second
/// 3. Members last
/// Within each role: alphabetical by name
List<Member> _sortMembers(List<Member> members) {
  final sorted = List<Member>.from(members);

  sorted.sort((a, b) {
    // First sort by role
    final roleComparison = _compareRoles(a.role, b.role);
    if (roleComparison != 0) {
      return roleComparison;
    }

    // Then by name
    return a.name.compareTo(b.name);
  });

  return sorted;
}

/// Compares two roles for sorting.
///
/// Returns negative if roleA comes before roleB,
/// positive if roleA comes after roleB,
/// zero if equal.
int _compareRoles(ClubRole roleA, ClubRole roleB) {
  const rank = {
    ClubRole.owner: 1,
    ClubRole.manager: 2,
    ClubRole.member: 3,
  };

  return rank[roleA]!.compareTo(rank[roleB]!);
}
