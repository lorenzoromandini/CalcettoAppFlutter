/// Base class for all domain-level failures.
///
/// Used to represent business logic errors that should be displayed to users.
abstract class Failure {
  final String message;

  const Failure(this.message);

  @override
  String toString() => message;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}

/// Authentication related failures.
class AuthFailure extends Failure {
  const AuthFailure(super.message);

  factory AuthFailure.invalidCredentials() =>
      const AuthFailure('Invalid email or password');

  factory AuthFailure.userNotFound() => const AuthFailure('User not found');

  factory AuthFailure.emailAlreadyInUse() =>
      const AuthFailure('Email is already registered');

  factory AuthFailure.weakPassword() =>
      const AuthFailure('Password is too weak');

  factory AuthFailure.unauthorized() =>
      const AuthFailure('Unauthorized access. Please login again.');

  factory AuthFailure.tokenExpired() =>
      const AuthFailure('Session expired. Please login again.');
}

/// Server/API related failures.
class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure(super.message, {this.statusCode});

  factory ServerFailure.badRequest() =>
      const ServerFailure('Invalid request', statusCode: 400);

  factory ServerFailure.notFound() =>
      const ServerFailure('Resource not found', statusCode: 404);

  factory ServerFailure.internalError() =>
      const ServerFailure('Server error. Please try again later',
          statusCode: 500);

  factory ServerFailure.unavailable() =>
      const ServerFailure('Service unavailable. Please try again later',
          statusCode: 503);

  factory ServerFailure.fromStatusCode(int code) {
    switch (code) {
      case 400:
        return ServerFailure.badRequest();
      case 404:
        return ServerFailure.notFound();
      case 401:
        return const ServerFailure('Unauthorized', statusCode: 401);
      case 403:
        return const ServerFailure('Forbidden', statusCode: 403);
      case 500:
        return ServerFailure.internalError();
      case 503:
        return ServerFailure.unavailable();
      default:
        return ServerFailure('Server error (code: $code)', statusCode: code);
    }
  }
}

/// Local cache/storage related failures.
class CacheFailure extends Failure {
  const CacheFailure(super.message);

  factory CacheFailure.readError() =>
      const CacheFailure('Failed to read from cache');

  factory CacheFailure.writeError() =>
      const CacheFailure('Failed to write to cache');

  factory CacheFailure.notFound() =>
      const CacheFailure('Data not found in cache');
}

/// Network connectivity failures.
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);

  factory NetworkFailure.noConnection() => const NetworkFailure(
      'No internet connection. Please check your network.');

  factory NetworkFailure.timeout() =>
      const NetworkFailure('Request timed out. Please try again.');

  factory NetworkFailure.unknown() =>
      const NetworkFailure('Network error occurred. Please try again.');
}
