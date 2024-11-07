import 'package:aidmanager_mobile/features/auth/presentation/providers/auth_provider.dart';
import 'package:aidmanager_mobile/features/projects/domain/entities/amount_chart.dart';
import 'package:aidmanager_mobile/features/projects/domain/entities/dashboard.dart';
import 'package:aidmanager_mobile/features/projects/domain/entities/goals_chart.dart';
import 'package:aidmanager_mobile/features/projects/domain/entities/task.dart';
import 'package:aidmanager_mobile/features/projects/domain/repositories/dashboards_repository.dart';
import 'package:aidmanager_mobile/features/projects/domain/repositories/tasks_repository.dart';
import 'package:aidmanager_mobile/features/projects/shared/exceptions/dashboard_exceptions.dart';
import 'package:flutter/foundation.dart';

class DashboardProvider extends ChangeNotifier {
  final DashboardsRepository dashboardsRepository;
  final TasksRepository tasksRepository;
  AuthProvider authProvider;

  DashboardProvider({
    required this.authProvider,
    required this.tasksRepository,
    required this.dashboardsRepository,
  });

  bool initialLoading = false;
  bool paymentsLoading = false;
  bool goalsLoading = false;

  List<Task> tasks = [];
  Dashboard? projectDashboard;

  Future<void> getDashboardInformationByProjectId(int projectId) async {
    initialLoading = true;

    try {
      final tasksList = await tasksRepository.getTasksByProjectId(projectId);
      final dashboard =
          await dashboardsRepository.getDashboardByProjectId(projectId);

      tasks = tasksList;
      projectDashboard = dashboard;
    } catch (e) {
      throw DashboardFetchByProjectException(
          "Error to get dashboard information for project: $projectId ");
    } finally {
      initialLoading = false;
      notifyListeners();
    }
  }

  Future<void> updatePaymentsChartByProjectId(
      int projectId, AmountChart chart) async {
    paymentsLoading = true;

    try {
      await dashboardsRepository.updateAmountChartByProjectId(projectId, chart);
    } catch (e) {
      throw AmountChartCreationException(
          "Error to update payments chart for project: $projectId");
    } finally {
      paymentsLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateGoalsChartByProjectId(
      int projectId, GoalsChart chart) async {
    paymentsLoading = true;

    try {
      await dashboardsRepository.updateGoalsChartByProjectId(projectId, chart);
    } catch (e) {
      throw GoalsChartCreationException(
          "Error to update goals cart for project: $projectId");
    } finally {
      paymentsLoading = false;
      notifyListeners();
    }
  }
}
