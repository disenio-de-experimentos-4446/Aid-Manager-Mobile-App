import 'package:aidmanager_mobile/features/projects/domain/entities/dashboard.dart';
import 'package:aidmanager_mobile/features/projects/infrastructure/mappers/amount_chart_mapper.dart';
import 'package:aidmanager_mobile/features/projects/infrastructure/mappers/goals_chart_mapper.dart';

class DashboardMapper {
  // Método para convertir JSON a un objeto Dashboard
  static Dashboard fromJson(Map<String, dynamic> json) {
    return Dashboard(
      projectId: json['projectId'],
      id: json['id'],
      linesChartBarData: (json['linesChartBarData'] as List)
          .map((i) => AmountChartMapper.fromJson(i))
          .toList(),
      barData: (json['barData'] as List)
          .map((i) => GoalsChartMapper.fromJson(i))
          .toList(),
      progressbar: json['progressbar'] != null
          ? List<int>.from(json['progressbar'])
          : null,
      status: json['status'] != null ? List<int>.from(json['status']) : null,
      tasks: json['tasks'] != null ? List<int>.from(json['tasks']) : null,
    );
  }

  // Método para convertir un objeto Dashboard a JSON
  static Map<String, dynamic> toJson(Dashboard dashboard) {
    return {
      'projectId': dashboard.projectId,
      'id': dashboard.id,
      'linesChartBarData':
          dashboard.linesChartBarData.map((i) => AmountChartMapper.toJson(i)).toList(),
      'barData': dashboard.barData.map((i) => GoalsChartMapper.toJson(i)).toList(),
      'progressbar': dashboard.progressbar,
      'status': dashboard.status,
      'tasks': dashboard.tasks,
    };
  }
}