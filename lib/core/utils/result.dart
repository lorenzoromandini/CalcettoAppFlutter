import '../errors/failures.dart';

/// A sealed class representing the result of an operation that can either succeed or fail.
///
/// Used throughout the app for functional error handling instead of throwing exceptions.
///
/// Usage:
/// ```dart
/// final result = await loginUser(email, password);
/// return result.fold(
///   (failure) => throw failure, // or handle the failure
///   (user) => user, // success case
/// );
/// ```
sealed class Result<T> {
  const Result();

  /// Returns the result of applying [success] to [Success.value] or [failure] to [Failure.error].
  R fold<R>(R Function(Failure failure) failure, R Function(T value) success);

  /// Maps the success value to a new value of type [R].
  Result<R> map<R>(R Function(T value) mapper);

  /// Maps the success value to a new Result of type [R].
  Future<Result<R>> flatMap<R>(Future<Result<R>> Function(T value) mapper);

  @override
  String toString() => 'Result<T>';
}

/// Represents a successful result with a value of type [T].
class Success<T> extends Result<T> {
  final T value;

  const Success(this.value);

  @override
  R fold<R>(R Function(Failure failure) failure, R Function(T value) success) {
    return success(value);
  }

  @override
  Result<R> map<R>(R Function(T value) mapper) {
    return Success(mapper(value));
  }

  @override
  Future<Result<R>> flatMap<R>(Future<Result<R>> Function(T value) mapper) {
    return mapper(value);
  }

  @override
  String toString() => 'Success($value)';
}

/// Represents a failed result with a [Failure] error.
class FailureResult<T> extends Result<T> {
  final Failure failure;

  const FailureResult(this.failure);

  @override
  R fold<R>(R Function(Failure failure) failure, R Function(T value) success) {
    return failure(this.failure);
  }

  @override
  Result<R> map<R>(R Function(T value) mapper) {
    return FailureResult(failure);
  }

  @override
  Future<Result<R>> flatMap<R>(Future<Result<R>> Function(T value) mapper) {
    return Future.value(FailureResult(failure));
  }

  @override
  String toString() => 'FailureResult($failure)';
}

/// Convenience type alias for a Result that returns a Future.
typedef ResultFuture<T> = Future<Result<T>>;
