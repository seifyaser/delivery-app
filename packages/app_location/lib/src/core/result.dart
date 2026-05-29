/// A sealed class representing the result of an operation.
/// Forces exhaustive handling of success and failure cases.
sealed class Result<F, S> {
  const Result();
}

/// Represents a successful operation, containing the resulting [value].
class Success<F, S> extends Result<F, S> {
  final S value;
  const Success(this.value);
}

/// Represents a failed operation, containing the [failure] reason.
class FailureResult<F, S> extends Result<F, S> {
  final F failure;
  const FailureResult(this.failure);
}
