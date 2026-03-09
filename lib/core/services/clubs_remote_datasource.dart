import 'package:dio/dio.dart';

import '../../features/clubs/data/models/club_model.dart';
import '../../features/clubs/data/models/member_model.dart';

/// Abstract interface for remote club data operations.
///
/// Provides API methods for fetching clubs and members data.
abstract class ClubsRemoteDataSource {
  /// Fetches list of clubs the user belongs to.
  Future<List<ClubModel>> getClubs();

  /// Fetches a single club by ID.
  Future<ClubModel> getClubById(String id);

  /// Fetches members of a specific club.
  Future<List<MemberModel>> getClubMembers(String clubId);

  /// Generates an invite code for a club (admin only).
  Future<String> generateInviteCode(String clubId);
}

/// Dio implementation of ClubsRemoteDataSource.
///
/// Makes HTTP requests to the backend API endpoints.
class DioClubsRemoteDataSource implements ClubsRemoteDataSource {
  final Dio _dio;

  DioClubsRemoteDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<List<ClubModel>> getClubs() async {
    final response = await _dio.get('/api/clubs');
    final data = response.data as List;
    return data
        .map((e) => ClubModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<ClubModel> getClubById(String id) async {
    final response = await _dio.get('/api/clubs/$id');
    return ClubModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<List<MemberModel>> getClubMembers(String clubId) async {
    final response = await _dio.get('/api/clubs/$clubId/members');
    final data = response.data as List;
    return data
        .map((e) => MemberModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<String> generateInviteCode(String clubId) async {
    final response = await _dio.post('/api/clubs/$clubId/invite');
    return response.data['code'] as String;
  }
}
