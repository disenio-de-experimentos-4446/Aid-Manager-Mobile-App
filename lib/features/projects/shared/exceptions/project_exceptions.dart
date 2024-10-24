class ProjectCreationException implements Exception {
  final String message;
  ProjectCreationException(this.message);

  @override
  String toString() => 'ProjectCreationException: $message';
}

class ProjectsFetchException implements Exception {
  final String message;
  ProjectsFetchException(this.message);

  @override
  String toString() => 'ProjectsFetchException: $message';
}

class ProjectDetailFetchException implements Exception {
  final String message;
  ProjectDetailFetchException(this.message);

  @override
  String toString() => 'ProjectDetailFetchException: $message';
}

class InvalidNumberOfImagesException implements Exception {
  final String message;
  InvalidNumberOfImagesException(this.message);

  @override
  String toString() => 'InvalidNumberOfImagesException: $message';
}

class InvalidDescriptionLengthException implements Exception {
  final String message;
  InvalidDescriptionLengthException(this.message);

  @override
  String toString() => 'InvalidDescriptionLengthException: $message';
}