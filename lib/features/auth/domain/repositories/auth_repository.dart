import '../../../../core/utils/result.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';

/// Abstract repository interface defining the authentication contract.
///
/// This interface is part of the domain layer and should not depend on
/// any external implementations. It defines the operations that any
/// authentication repository must implement.
abstract class AuthRepository {
  /// Authenticates a user with email and password.
  ///
  /// Returns a [User] entity on success, or an [AuthFailure] on failure.
  Future<Result<User>> login(String email, String password);

  /// Logs out the current user.
  ///
  /// Clears stored tokens and cached user data.
  Future<Result<void>> logout();

  /// Retrieves the currently authenticated user.
  ///
  /// Returns [User] if authenticated, or null if not logged in.
  Future<Result<User?>> getCurrentUser();

  /// Checks if a user is currently authenticated.
  ///
  /// Returns true if valid credentials exist in storage.
  Future<Result<bool>> isAuthenticated();
}
