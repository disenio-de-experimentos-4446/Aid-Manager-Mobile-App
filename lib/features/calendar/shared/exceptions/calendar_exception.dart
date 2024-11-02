class TasksFetchException implements Exception {
  final String message;
  TasksFetchException(this.message);

  @override
  String toString() => 'TasksFetchException: $message';
}

class NoTasksInCompanyException implements Exception {
  final String message;
  NoTasksInCompanyException(this.message);

  @override
  String toString() => 'NoTasksInCompanyException: $message';
}