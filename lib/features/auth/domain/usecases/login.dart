import '../../../../core/utils/result.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Validates email format using RFC 5322 simplified pattern.
bool isValidEmail(String email) {
  return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
}

/// Async use case for user login with email and password.
///
/// Encapsulates the business logic for authentication:
/// 1. Validate email format (not empty, valid email pattern)
/// 2. Validate password (not empty, minimum 6 characters)
/// 3. Delegate to repository for actual authentication
///
/// Returns a [User] entity on success, or a specific [Failure] on validation failure.
class LoginAsyncUseCase {
  final AuthRepository _repository;

  LoginAsyncUseCase(this._repository);

  /// Executes the async login use case.
  ///
  /// First validates inputs, then calls the repository login method.
  /// Returns [Success<User>] on authentication success,
  /// or [FailureResult] with [AuthFailure] or [ServerFailure] on failure.
  Future<Result<User>> call(String email, String password) async {
    // Validate email
    if (email.trim().isEmpty) {
      return const FailureResult(AuthFailure('Email is required'));
    }
    if (!isValidEmail(email)) {
      return const FailureResult(
          AuthFailure('Please enter a valid email address'));
    }

    // Validate password
    if (password.isEmpty) {
      return const FailureResult(AuthFailure('Password is required'));
    }
    if (password.length < 6) {
      return const FailureResult(
          AuthFailure('Password must be at least 6 characters'));
    }

    // Call repository
    return _repository.login(email, password);
  }
}
