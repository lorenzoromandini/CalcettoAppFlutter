import '../../../../core/utils/result.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Async use case for user signup with registration data.
///
/// Encapsulates the business logic for user registration:
/// 1. Validate all required fields (email, first name, last name, password)
/// 2. Validate email format
/// 3. Validate password strength (minimum 6 characters)
/// 4. Validate name fields (minimum 2 characters)
/// 5. Validate password confirmation matches
/// 6. Generate nickname from first name if not provided
/// 7. Delegate to repository for actual registration
///
/// Returns a [User] entity on success, or a specific [Failure] on validation failure.
class SignupAsyncUseCase {
  final AuthRepository _repository;

  SignupAsyncUseCase(this._repository);

  /// Executes the async signup use case.
  ///
  /// Validates all inputs, then calls the repository signup method.
  /// Returns [Success<User>] on registration success,
  /// or [FailureResult] with [AuthFailure] or [ServerFailure] on failure.
  Future<Result<User>> call({
    required String email,
    required String firstName,
    required String lastName,
    String? nickname,
    required String password,
    required String confirmPassword,
  }) async {
    // Validate email
    if (email.trim().isEmpty) {
      return const FailureResult(AuthFailure('Email is required'));
    }
    if (!isValidEmail(email)) {
      return const FailureResult(
          AuthFailure('Please enter a valid email address'));
    }

    // Validate first name
    if (firstName.trim().isEmpty) {
      return const FailureResult(AuthFailure('First name is required'));
    }
    if (firstName.trim().length < 2) {
      return const FailureResult(
          AuthFailure('First name must be at least 2 characters'));
    }

    // Validate last name
    if (lastName.trim().isEmpty) {
      return const FailureResult(AuthFailure('Last name is required'));
    }
    if (lastName.trim().length < 2) {
      return const FailureResult(
          AuthFailure('Last name must be at least 2 characters'));
    }

    // Validate password
    if (password.isEmpty) {
      return const FailureResult(AuthFailure('Password is required'));
    }
    if (password.length < 6) {
      return const FailureResult(
          AuthFailure('Password must be at least 6 characters'));
    }

    // Validate password confirmation
    if (password != confirmPassword) {
      return const FailureResult(AuthFailure('Passwords do not match'));
    }

    // Use provided nickname or generate from first name
    final userNickname = nickname?.trim().isNotEmpty == true
        ? nickname
        : firstName.split(' ')[0];

    // Call repository
    return _repository.signup(
      email: email,
      firstName: firstName,
      lastName: lastName,
      nickname: userNickname,
      password: password,
    );
  }
}

/// Validates email format using RFC 5322 simplified pattern.
bool isValidEmail(String email) {
  return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
}
