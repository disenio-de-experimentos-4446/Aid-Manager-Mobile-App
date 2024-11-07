import 'package:aidmanager_mobile/features/projects/domain/entities/amount_chart.dart';

// TODO: "implementar";
class AmountChartMapper {

  static AmountChart fromJson(Map<String, dynamic> json) {
    return AmountChart(
      data1: json['data1'],
      data2: json['data2'],
      data3: json['data3'],
      data4: json['data4'],
      data5: json['data5'],
      data6: json['data6'],
      data7: json['data7'],
    );
  }

  static Map<String, dynamic> toJson(AmountChart chart) {
    return {
      'data1': chart.data1,
      'data2': chart.data2,
      'data3': chart.data3,
      'data4': chart.data4,
      'data5': chart.data5,
      'data6': chart.data6,
      'data7': chart.data7,
    };
  }
  
}