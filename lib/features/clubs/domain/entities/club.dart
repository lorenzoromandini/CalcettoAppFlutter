import 'package:freezed_annotation/freezed_annotation.dart';

import 'club_privilege.dart';

part 'club.freezed.dart';
part 'club.g.dart';

/// Immutable Club entity representing a football club.
///
/// Contains basic club information displayed in club lists and details.
/// Uses ClubPrivilege for the user's management level in the club.
@freezed
class Club with _$Club {
  const factory Club({
    required String id,
    required String name,
    String? logoUrl,
    required int memberCount,
    required ClubPrivilege userPrivilege,
    String? description,
    required DateTime createdAt,
  }) = _Club;

  /// Creates a Club from a JSON map (for deserialization).
  factory Club.fromJson(Map<String, dynamic> json) => _$ClubFromJson(json);
}
