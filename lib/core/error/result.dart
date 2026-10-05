sealed class Result<S, E extends Exception> {
  const Result();
}

final class Success<S, E extends Exception> extends Result<S, E> {
  const Success(this.value, this.message);
  final S value;
  final String? message;
}

final class Failure<S, E extends Exception> extends Result<S, E> {
  const Failure(this.message, {this.exception});
  final E? exception;
  final String message;
}
