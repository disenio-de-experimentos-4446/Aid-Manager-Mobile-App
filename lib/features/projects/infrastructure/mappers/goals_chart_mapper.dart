import 'package:aidmanager_mobile/features/projects/domain/entities/goals_chart.dart';

// TODO: "implementar";
class GoalsChartMapper {

  static GoalsChart fromJson(Map<String, dynamic> json) {
    return GoalsChart(
      sunAmmount: json['sunAmount'],
      monAmmount: json['monAmount'],
      tueAmmount: json['tueAmount'],
      wedAmmount: json['wedAmount'],
      thuAmmount: json['thuAmount'],
      friAmmount: json['friAmount'],
      satAmmount: json['satAmount'],
    );
  }

  static Map<String, dynamic> toJson(GoalsChart goalsChart) {
    return {
      'sunAmount': goalsChart.sunAmmount,
      'monAmount': goalsChart.monAmmount,
      'tueAmount': goalsChart.tueAmmount,
      'wedAmount': goalsChart.wedAmmount,
      'thuAmount': goalsChart.thuAmmount,
      'friAmount': goalsChart.friAmmount,
      'satAmount': goalsChart.satAmmount,
    };
  }

}