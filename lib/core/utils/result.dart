import 'package:project/core/error/failures.dart';

/// A sealed class that represents either a successful [value] or a [Failure].
///
/// Usage:
/// ```dart
/// final result = await repository.getCurrentLocation();
/// switch (result) {
///   case Success(:final value):  // use value
///   case FailureResult(:final failure): // use failure
/// }
/// ```
sealed class Result<T> {
  const Result();
}

/// Represents a successful outcome carrying a [value].
final class Success<T> extends Result<T> {
  final T value;
  const Success(this.value);
}

/// Represents a failure carrying a [Failure] object.
final class FailureResult<T> extends Result<T> {
  final Failure failure;
  const FailureResult(this.failure);
}
