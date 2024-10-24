class TaskCreationException implements Exception {
  final String message;
  TaskCreationException(this.message);

  @override
  String toString() => 'TaskCreationException: $message';
}

class TasksFetchByProjectException implements Exception {
  final String message;
  TasksFetchByProjectException(this.message);

  @override
  String toString() => 'TasksFetchByProjectException: $message';
}