import 'package:aidmanager_mobile/features/projects/domain/datasources/dashboards_datasource.dart';
import 'package:aidmanager_mobile/features/projects/domain/entities/amount_chart.dart';
import 'package:aidmanager_mobile/features/projects/domain/entities/dashboard.dart';
import 'package:aidmanager_mobile/features/projects/domain/entities/goals_chart.dart';
import 'package:aidmanager_mobile/features/projects/domain/repositories/dashboards_repository.dart';

class DasboardsRepositoryImpl implements DashboardsRepository {

  final DashboardsDatasource datasource;

  DasboardsRepositoryImpl({required this.datasource});

  @override
  Future<void> createDashboard(Dashboard dashboard) {
    return datasource.createDashboard(dashboard);
  }

  @override
  Future<List<Dashboard>> getAllDashboardDataByCompanyId(int companyId) {
    return datasource.getAllDashboardDataByCompanyId(companyId);
  }

  @override
  Future<Dashboard> getDashboardByProjectId(int projectId) {
    return datasource.getDashboardByProjectId(projectId);
  }

  @override
  Future<void> updateAmountChartByProjectId(int projectId, AmountChart chart) {
    return datasource.updateAmountChartByProjectId(projectId, chart);
  }

  @override
  Future<void> updateGoalsChartByProjectId(int projectId, GoalsChart chart) {
    return datasource.updateGoalsChartByProjectId(projectId, chart);
  }

}