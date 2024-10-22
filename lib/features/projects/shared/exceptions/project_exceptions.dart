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