/// Base class for all data layer exceptions.
///
/// These are thrown by data sources and caught by repositories,
/// which then map them to domain-level [Failure] types.
abstract class AppException implements Exception {
  final String message;

  const AppException(this.message);

  @override
  String toString() => '${runtimeType}: $message';
}

/// Authentication exceptions thrown by auth data sources.
class AuthException extends AppException {
  const AuthException(super.message);

  factory AuthException.invalidCredentials() =>
      const AuthException('Invalid email or password');

  factory AuthException.userNotFound() => const AuthException('User not found');

  factory AuthException.emailAlreadyInUse() =>
      const AuthException('Email is already registered');

  factory AuthException.weakPassword() =>
      const AuthException('Password is too weak');

  factory AuthException.unauthorized() =>
      const AuthException('Unauthorized access');

  factory AuthException.tokenExpired() =>
      const AuthException('Token has expired');

  factory AuthException.invalidToken() => const AuthException('Invalid token');
}

/// Server/API exceptions thrown by remote data sources.
class ServerException extends AppException {
  final int? statusCode;

  const ServerException(super.message, {this.statusCode});

  factory ServerException.badRequest() =>
      const ServerException('Bad request', statusCode: 400);

  factory ServerException.notFound() =>
      const ServerException('Resource not found', statusCode: 404);

  factory ServerException.internalError() =>
      const ServerException('Internal server error', statusCode: 500);

  factory ServerException.unavailable() =>
      const ServerException('Service unavailable', statusCode: 503);

  factory ServerException.fromStatusCode(int code) {
    switch (code) {
      case 400:
        return ServerException.badRequest();
      case 404:
        return ServerException.notFound();
      case 401:
        return const ServerException('Unauthorized', statusCode: 401);
      case 403:
        return const ServerException('Forbidden', statusCode: 403);
      case 500:
        return ServerException.internalError();
      case 503:
        return ServerException.unavailable();
      default:
        return ServerException('Server error (code: $code)', statusCode: code);
    }
  }
}

/// Cache exceptions thrown by local storage data sources.
class CacheException extends AppException {
  const CacheException(super.message);

  factory CacheException.readError() =>
      const CacheException('Failed to read from cache');

  factory CacheException.writeError() =>
      const CacheException('Failed to write to cache');

  factory CacheException.notFound() =>
      const CacheException('Data not found in cache');

  factory CacheException.boxNotOpen() =>
      const CacheException('Hive box is not open');
}

/// Network exceptions for connectivity issues.
class NetworkException extends AppException {
  const NetworkException(super.message);

  factory NetworkException.noConnection() =>
      const NetworkException('No internet connection');

  factory NetworkException.timeout() =>
      const NetworkException('Request timed out');

  factory NetworkException.unknown() =>
      const NetworkException('Unknown network error');
}
