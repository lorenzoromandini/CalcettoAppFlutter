import '../../../../core/utils/result.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/services/connectivity_service.dart';
import '../../../../core/services/clubs_local_datasource.dart';
import '../../../../core/services/clubs_remote_datasource.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/club.dart';
import '../../domain/entities/member.dart';
import '../../domain/repositories/clubs_repository.dart';
import '../../data/models/member_model.dart';

/// Implementation of ClubsRepository with network awareness and cache-first strategy.
class ClubsRepositoryImpl implements ClubsRepository {
  final ClubsRemoteDataSource _remote;
  final ClubsLocalDataSource _local;
  final ConnectivityService _connectivity;

  ClubsRepositoryImpl({
    required ClubsRemoteDataSource remote,
    required ClubsLocalDataSource local,
    required ConnectivityService connectivity,
  })  : _remote = remote,
        _local = local,
        _connectivity = connectivity;

  @override
  Future<Result<List<Club>>> getClubs() async {
    try {
      final isOnline = await _connectivity.isOnline;

      if (isOnline) {
        try {
          final clubs = await _remote.getClubs();
          await _local.cacheClubs(clubs);
          return Success(clubs.map((m) => m.toEntity()).toList());
        } on DioException catch (e) {
          // Network error: try cache fallback
          final cached = await _local.getCachedClubs();
          if (cached != null) {
            return Success(cached.map((m) => m.toEntity()).toList());
          }
          return FailureResult(NetworkFailure.unknown());
        }
      } else {
        // Offline: try cache
        final cached = await _local.getCachedClubs();
        if (cached != null) {
          return Success(cached.map((m) => m.toEntity()).toList());
        }
        return FailureResult(NetworkFailure.noConnection());
      }
    } on Exception catch (e) {
      return FailureResult(CacheFailure.readError());
    } catch (e) {
      return FailureResult(ServerFailure.internalError());
    }
  }

  @override
  Future<Result<Club>> getClubById(String id) async {
    try {
      final isOnline = await _connectivity.isOnline;

      if (isOnline) {
        try {
          final club = await _remote.getClubById(id);
          await _local.cacheClubs([club]);
          return Success(club.toEntity());
        } on DioException {
          final cached = await _local.getCachedClubs();
          if (cached != null) {
            try {
              final matching = cached.firstWhere((m) => m.id == id);
              return Success(matching.toEntity());
            } on StateError {
              return FailureResult(CacheFailure.notFound());
            }
          }
          return FailureResult(NetworkFailure.unknown());
        }
      } else {
        final cached = await _local.getCachedClubs();
        if (cached != null) {
          try {
            final matching = cached.firstWhere((m) => m.id == id);
            return Success(matching.toEntity());
          } on StateError {
            return FailureResult(CacheFailure.notFound());
          }
        }
        return FailureResult(NetworkFailure.noConnection());
      }
    } on Exception {
      return FailureResult(CacheFailure.readError());
    } catch (_) {
      return FailureResult(ServerFailure.internalError());
    }
  }

  @override
  Future<Result<List<Member>>> getClubMembers(String clubId) async {
    try {
      final isOnline = await _connectivity.isOnline;

      if (isOnline) {
        try {
          final members = await _remote.getClubMembers(clubId);
          await _local.cacheClubMembers(clubId, members);
          return Success(members.map((m) => m.toEntity()).toList());
        } on DioException catch (e) {
          final cached = await _local.getCachedClubMembers(clubId);
          if (cached != null) {
            return Success(cached.map((m) => m.toEntity()).toList());
          }
          return FailureResult(NetworkFailure.unknown());
        }
      } else {
        final cached = await _local.getCachedClubMembers(clubId);
        if (cached != null) {
          return Success(cached.map((m) => m.toEntity()).toList());
        }
        return FailureResult(NetworkFailure.noConnection());
      }
    } on Exception catch (e) {
      return FailureResult(CacheFailure.readError());
    } catch (e) {
      return FailureResult(ServerFailure.internalError());
    }
  }

  @override
  Future<Result<String>> generateInviteCode(String clubId) async {
    try {
      final isOnline = await _connectivity.isOnline;

      if (!isOnline) {
        return FailureResult(NetworkFailure.noConnection());
      }

      try {
        final code = await _remote.generateInviteCode(clubId);
        return Success(code);
      } on DioException catch (e) {
        if (e.response?.statusCode != null) {
          return FailureResult(
              ServerFailure.fromStatusCode(e.response!.statusCode!));
        }
        return FailureResult(NetworkFailure.unknown());
      }
    } catch (_) {
      return FailureResult(ServerFailure.internalError());
    }
  }

  @override
  Future<Result<void>> deleteClub(String clubId) async {
    try {
      final isOnline = await _connectivity.isOnline;

      if (!isOnline) {
        return FailureResult(NetworkFailure.noConnection());
      }

      try {
        await _remote.deleteClub(clubId);
        await _local.removeClub(clubId);
        return const Success(null);
      } on DioException catch (e) {
        if (e.response?.statusCode != null) {
          return FailureResult(
              ServerFailure.fromStatusCode(e.response!.statusCode!));
        }
        return FailureResult(NetworkFailure.unknown());
      }
    } catch (_) {
      return FailureResult(ServerFailure.internalError());
    }
  }
}
