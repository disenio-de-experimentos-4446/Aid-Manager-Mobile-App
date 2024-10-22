import 'dart:convert';
import 'dart:io';

import 'package:aidmanager_mobile/features/projects/domain/datasources/dashboards_datasource.dart';
import 'package:aidmanager_mobile/features/projects/domain/entities/amount_chart.dart';
import 'package:aidmanager_mobile/features/projects/domain/entities/dashboard.dart';
import 'package:aidmanager_mobile/features/projects/domain/entities/goals_chart.dart';
import 'package:aidmanager_mobile/features/projects/infrastructure/mappers/amount_chart_mapper.dart';
import 'package:aidmanager_mobile/features/projects/infrastructure/mappers/dashboard_mapper.dart';
import 'package:aidmanager_mobile/features/projects/infrastructure/mappers/goals_chart_mapper.dart';
import 'package:aidmanager_mobile/shared/service/http_service.dart';

class DashboardsDatasourceImpl extends HttpService implements DashboardsDatasource {

  @override
  Future<void> createDashboard(Dashboard dashboard) async {
    final requestBody = DashboardMapper.toJson(dashboard);

    try {
      final response = await dio.post(
        '/analytics',
        data: jsonEncode(requestBody),
      );

      if(response.statusCode != HttpStatus.ok) {
        throw Exception('Failed to create a new Dashboard: ${response.statusCode}');
      }

      if (response.data == null || response.data.isEmpty) {
        throw Exception('Failed to create a new project: Response body is empty');
      }

    } catch (e) {
      throw Exception('Failed to create a new Dashboard: $e');
    }
  }

  @override
  Future<List<Dashboard>> getAllDashboardDataByCompanyId(int companyId) async {
    try {
      final response = await dio.get('/analytics/$companyId');

      if(response.statusCode == HttpStatus.ok) {
        final List<dynamic> dashboardsJson = response.data;
        return dashboardsJson.map((json) => DashboardMapper.fromJson(json)).toList();
      }
      else {
        throw Exception('Failed to fetch dashboards data for $companyId');
      }

    } catch (e) {
      throw Exception('Failed to fetch dashboards by id $companyId: $e');
    }
  }

  @override
  Future<Dashboard> getDashboardByProjectId(int projectId) async {
    try {
      final response = await dio.get('/projects/$projectId/analytics');

      if(response.statusCode == HttpStatus.ok) {
        final dynamic dahsboardJson = response.data;
        return DashboardMapper.fromJson(dahsboardJson);
      }
      else {
        throw Exception('Failed to fetch dashboard with projectId: $projectId');
      }

    } catch (e) {
      throw Exception('Failed to fetch dashboard by project id $projectId: $e');
    }
  }

  @override
  Future<void> updateAmountChartByProjectId(int projectId, AmountChart chart) async {
    final requestBody = AmountChartMapper.toJson(chart);

    try {
      final response = await dio.patch(
        '/projects/$projectId/analytics/lines',
        data: jsonEncode(requestBody)
      );

      if(response.statusCode != HttpStatus.ok) {
        throw Exception('Failed to update AmountChart in projectID $projectId');
      }

    } catch (e) {
      throw Exception('Failed to update AmountChart in projectID $projectId: $e');
    }
  }

  @override
  Future<void> updateGoalsChartByProjectId(int projectId, GoalsChart chart) async {
    final requestBody = GoalsChartMapper.toJson(chart);

    try {
      final response = await dio.patch(
        '/projects/$projectId/analytics/bardata',
        data: jsonEncode(requestBody)
      );

      if(response.statusCode != HttpStatus.ok) {
        throw Exception('Failed to update AmountChart in projectID $projectId');
      }

    } catch (e) {
      throw Exception('Failed to update AmountChart in projectID $projectId: $e');
    }
  }
  
}