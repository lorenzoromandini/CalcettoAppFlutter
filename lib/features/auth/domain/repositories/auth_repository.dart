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

  /// Retrieves the currently authenticated user from local cache.
  ///
  /// Returns [User] if authenticated, or null if not logged in.
  Future<Result<User?>> getCurrentUser();

  /// Fetches the current user from the server (not from cache).
  ///
  /// Returns [User] if authenticated, or null if not logged in.
  /// Use this when you need fresh data from the server.
  Future<Result<User?>> fetchCurrentUserFromServer();

  /// Checks if a user is currently authenticated.
  ///
  /// Returns true if valid credentials exist in storage.
  Future<Result<bool>> isAuthenticated();

  /// Registers a new user with the provided details.
  ///
  /// Returns a [User] entity on success, or an [AuthFailure] on failure.
  Future<Result<User>> signup({
    required String email,
    required String firstName,
    required String lastName,
    String? nickname,
    required String password,
  });

  /// Updates the current user's profile information.
  ///
  /// Returns the updated [User] entity on success.
  /// Password is optional - if null or empty, it won't be updated.
  Future<Result<User>> updateProfile({
    required String firstName,
    required String lastName,
    String? nickname,
    String? password,
  });
}
