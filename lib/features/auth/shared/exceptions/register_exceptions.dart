class InvalidCodeAccessException implements Exception {
  final String message;
  InvalidCodeAccessException(this.message);

  @override
  String toString() => message;
}

class SignUpFailedException implements Exception {
  final String message;
  SignUpFailedException(this.message);

  @override
  String toString() => message;
}
