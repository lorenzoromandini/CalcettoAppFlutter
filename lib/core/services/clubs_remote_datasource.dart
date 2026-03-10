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
    try {
      print('REMOTE DATASOURCE: Fetching clubs...');
      final response = await _dio.post('/clubs/getClubs');
      print('REMOTE DATASOURCE: Response status: ${response.statusCode}');
      print('REMOTE DATASOURCE: Response data: ${response.data}');

      if (response.data == null || response.data is! List) {
        print('REMOTE DATASOURCE: Empty clubs list');
        return [];
      }

      final data = response.data as List;
      final clubs = data
          .map((e) => ClubModel.fromJson(e as Map<String, dynamic>))
          .toList();
      print('REMOTE DATASOURCE: Parsed ${clubs.length} clubs');
      return clubs;
    } catch (e) {
      print('REMOTE DATASOURCE ERROR: $e');
      rethrow;
    }
  }

  @override
  Future<ClubModel> getClubById(String id) async {
    final response = await _dio.get('/clubs/$id');
    return ClubModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<List<MemberModel>> getClubMembers(String clubId) async {
    final response = await _dio.get('/clubs/$clubId/members');
    final data = response.data as List;
    return data
        .map((e) => MemberModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<String> generateInviteCode(String clubId) async {
    final response = await _dio.post('/clubs/$clubId/invite');
    return response.data['code'] as String;
  }
}
