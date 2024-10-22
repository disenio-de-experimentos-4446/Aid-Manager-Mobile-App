class DashboardFetchByProjectException implements Exception {
  final String message;
  DashboardFetchByProjectException(this.message);

  @override
  String toString() => 'DashboardFetchByProjectException: $message';
}

class AmountChartCreationException implements Exception {
  final String message;
  AmountChartCreationException(this.message);

  @override
  String toString() => 'AmountChartCreationException: $message';
}

class GoalsChartCreationException implements Exception {
  final String message;
  GoalsChartCreationException(this.message);

  @override
  String toString() => 'GoalsChartCreationException: $message';
}

class TasksChartFetchException implements Exception {
  final String message;
  TasksChartFetchException(this.message);

  @override
  String toString() => 'TasksChartFetchException: $message';
}