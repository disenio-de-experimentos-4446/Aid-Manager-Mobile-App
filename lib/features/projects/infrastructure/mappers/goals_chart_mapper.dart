import 'package:aidmanager_mobile/features/projects/domain/entities/goals_chart.dart';

class GoalsChartMapper {

  static GoalsChart fromJson(Map<String, dynamic> json) {
    return GoalsChart(
      sunAmmount: json['sunAmmount'],
      monAmmount: json['monAmmount'],
      tueAmmount: json['tueAmmount'],
      wedAmmount: json['wedAmmount'],
      thuAmmount: json['thuAmmount'],
      friAmmount: json['friAmmount'],
      satAmmount: json['satAmmount'],
    );
  }

  static Map<String, dynamic> toJson(GoalsChart chart) {
    return {
      'sunAmmount': chart.sunAmmount,
      'monAmmount': chart.monAmmount,
      'tueAmmount': chart.tueAmmount,
      'wedAmmount': chart.wedAmmount,
      'thuAmmount': chart.thuAmmount,
      'friAmmount': chart.friAmmount,
      'satAmmount': chart.satAmmount,
    };
  }

}