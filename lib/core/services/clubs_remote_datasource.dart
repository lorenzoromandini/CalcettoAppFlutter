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

  /// Deletes a club (owner only).
  Future<void> deleteClub(String clubId);

  /// Creates a new club (owner becomes the creator).
  Future<ClubModel> createClub({
    required String name,
    String? description,
  });

  /// Join a club using an invite code.
  Future<ClubModel> joinClub(String inviteCode);

  /// Get deleted clubs for recovery.
  Future<List<ClubModel>> getDeletedClubs();

  /// Recover a deleted club.
  Future<ClubModel> recoverClub(String clubId);
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
      final response = await _dio.post('/clubs/getClubs');

      if (response.data == null || response.data is! List) {
        return [];
      }

      final data = response.data as List;
      final clubs = data
          .map((e) => ClubModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return clubs;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ClubModel> getClubById(String id) async {
    final response = await _dio.post(
      '/clubs/getClubById',
      data: {'id': id},
    );
    return ClubModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<List<MemberModel>> getClubMembers(String clubId) async {
    try {
      final response = await _dio.post(
        '/clubs/getClubMembers',
        data: {'clubIdStr': clubId},
      );

      if (response.data == null || response.data is! List) {
        throw Exception('Invalid response format');
      }

      final data = response.data as List;
      final members = data
          .map((e) => MemberModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return members;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> generateInviteCode(String clubId) async {
    final response = await _dio.post(
      '/clubs/generateInviteCode',
      data: {'clubIdStr': clubId},
    );
    return response.data['code'] as String;
  }

  @override
  Future<void> deleteClub(String clubId) async {
    await _dio.post(
      '/clubs/deleteClub',
      data: {'clubIdStr': clubId},
    );
  }

  @override
  Future<ClubModel> createClub({
    required String name,
    String? description,
  }) async {
    final response = await _dio.post(
      '/clubs/createClub',
      data: {
        'name': name,
        'description': description,
      },
    );
    return ClubModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<ClubModel> joinClub(String inviteCode) async {
    final response = await _dio.post(
      '/clubs/joinClub',
      data: {'inviteCode': inviteCode},
    );
    return ClubModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<List<ClubModel>> getDeletedClubs() async {
    try {
      final response = await _dio.post('/clubs/getDeletedClubs');

      if (response.data == null || response.data is! List) {
        return [];
      }

      final data = response.data as List;
      final clubs = data
          .map((e) => ClubModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return clubs;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ClubModel> recoverClub(String clubId) async {
    final response = await _dio.post(
      '/clubs/recoverClub',
      data: {'clubIdStr': clubId},
    );
    return ClubModel.fromJson(response.data as Map<String, dynamic>);
  }
}
