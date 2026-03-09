/// Common type definitions used throughout the application.

import 'result.dart';

/// JSON Map type alias for cleaner code.
typedef JsonMap = Map<String, dynamic>;

/// JSON List type alias.
typedef JsonList = List<dynamic>;

/// Result Future type alias for use case return types.
///
/// Usage:
/// ```dart
/// class LoginUseCase {
///   ResultFuture<User> call(LoginParams params) async {
///     // Returns Result<User, Failure>
///   }
/// }
/// ```
typedef ResultFuture<T> = Future<Result<T>>;

/// Unit type for cases where no value is returned.
///
/// Used when a use case only needs to signal success or failure.
typedef Unit = void;

/// Stream of Result types for real-time updates.
typedef ResultStream<T> = Stream<Result<T>>;

/// Callback function type for value changes.
typedef ValueCallback<T> = void Function(T value);
