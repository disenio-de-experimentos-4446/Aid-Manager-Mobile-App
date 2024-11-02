class HomeFetchException implements Exception {
  final String message;
  HomeFetchException(this.message);

  @override
  String toString() => 'HomeFetchException: $message';
}

class HomeDataParseException implements Exception {
  final String message;
  HomeDataParseException(this.message);

  @override
  String toString() => 'HomeDataParseException: $message';
}

class HomeNetworkException implements Exception {
  final String message;
  HomeNetworkException(this.message);

  @override
  String toString() => 'HomeNetworkException: $message';
}

class HomeUnknownException implements Exception {
  final String message;
  HomeUnknownException(this.message);

  @override
  String toString() => 'HomeUnknownException: $message';
}