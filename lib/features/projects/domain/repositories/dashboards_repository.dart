import 'package:aidmanager_mobile/features/projects/domain/entities/amount_chart.dart';
import 'package:aidmanager_mobile/features/projects/domain/entities/dashboard.dart';
import 'package:aidmanager_mobile/features/projects/domain/entities/goals_chart.dart';

// TODO: "implementar";
abstract class DashboardsRepository {
  Future<void> createDashboard(Dashboard dashboard);
  Future<Dashboard> getDashboardByProjectId(int projectId);
  Future<void> updateAmountChartByProjectId(int projectId, AmountChart chart);
  Future<void> updateGoalsChartByProjectId(int projectId, GoalsChart chart);
  Future<List<Dashboard>> getAllDashboardDataByCompanyId(int companyId);
}