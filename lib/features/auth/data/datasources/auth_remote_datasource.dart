import 'package:dio/dio.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';

/// Abstract interface for remote authentication data operations.
abstract class AuthRemoteDataSource {
  /// Authenticates user with email and password via API.
  Future<UserModel> login(String email, String password);
}

/// Implementation of [AuthRemoteDataSource] using Dio HTTP client.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '${AppConstants.apiBaseUrl}/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        if (data['success'] == true) {
          final user = data['user'] as Map<String, dynamic>;
          return UserModel(
            id: user['id'].toString(),
            email: user['email'] as String,
            name: '${user['firstName']} ${user['lastName']}',
            token: data['token'] as String?,
          );
        } else {
          throw AuthException(
              data['error'] as String? ?? 'Invalid email or password');
        }
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        throw AuthException('Invalid email or password');
      } else {
        throw ServerException(
          'Authentication failed with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw ServerException('Connection timeout. Please try again.');
      } else if (e.type == DioExceptionType.connectionError) {
        throw ServerException(
            'No internet connection. Please check your network.');
      } else if (e.response != null) {
        if (e.response!.statusCode == 401 || e.response!.statusCode == 403) {
          throw AuthException('Invalid email or password');
        } else if (e.response!.statusCode == 500) {
          throw ServerException('Server error. Please try again later.');
        } else if (e.response!.statusCode == 503) {
          throw ServerException('Service unavailable. Please try again later.');
        }
      }
      throw ServerException('Network error: ${e.message}');
    } catch (e) {
      if (e is AuthException || e is ServerException) {
        rethrow;
      }
      throw ServerException('Unexpected error: $e');
    }
  }
}
