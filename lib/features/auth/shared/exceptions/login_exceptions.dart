class EmptyFieldsException implements Exception {
  final String message;
  EmptyFieldsException(this.message);

  @override
  String toString() => message;
}

class SignInFailedException implements Exception {
  final String message;
  SignInFailedException(this.message);

  @override
  String toString() => message;
}

class InvalidEmailFormatException implements Exception {
  final String message;
  InvalidEmailFormatException(this.message);

  @override
  String toString() => message;
}