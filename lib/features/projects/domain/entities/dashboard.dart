import 'package:aidmanager_mobile/features/projects/domain/entities/amount_chart.dart';
import 'package:aidmanager_mobile/features/projects/domain/entities/goals_chart.dart';

class Dashboard {
  final int projectId;
  final int id;
  final List<AmountChart> linesChartBarData;
  final List<GoalsChart> barData;
  final List<int> progressbar;
  final List<int> status;
  final List<int> tasks;

  Dashboard({
    required this.projectId,
    required this.id,
    required this.linesChartBarData,
    required this.barData,
    required this.progressbar,
    required this.status,
    required this.tasks,
  });
}

// TODO: "implementar";