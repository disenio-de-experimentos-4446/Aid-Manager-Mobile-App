import 'package:aidmanager_mobile/config/mocks/bar_data.dart';
import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BarChartCard extends StatelessWidget {

  final String projectId;
  final List<double> summary;

  const BarChartCard({super.key, required this.summary, required this.projectId});

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      sunAmount: summary[0],
      monAmount: summary[1],
      tueAmount: summary[2],
      wedAmount: summary[3],
      thuAmount: summary[4],
      friAmount: summary[5],
      satAmount: summary[6],
    );

    myBarData.initializeBarData();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color.fromARGB(255, 211, 211, 211)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Weekly progress',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '24',
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.darkGreen,
                          ),
                        ),
                        TextSpan(
                          text: '/ 100 goals completed',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.normal,
                              color: const Color.fromARGB(139, 0, 0, 0),
                              letterSpacing: 1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  context.go('/projects/$projectId/dashboard/edit-goals');
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                  foregroundColor: Colors.green,
                  backgroundColor: CustomColors.fieldGrey,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: Colors.green,
                      size: 30.0,
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      'Edit',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 40.0),
          Center(
            child: SizedBox(
              height: 350.0,
              child: BarChart(
                BarChartData(
                  maxY: 100,
                  minY: 0,
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    show: true,
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: getBottomTitles,
                          reservedSize: 30.0),
                    ),
                  ),
                  barGroups: myBarData.barData
                      .map((data) => BarChartGroupData(x: data.x, barRods: [
                            BarChartRodData(
                                toY: data.y,
                                color: Colors.green,
                                width: 15,
                                backDrawRodData: BackgroundBarChartRodData(
                                    show: true,
                                    toY: 100,
                                    color: const Color.fromARGB(
                                        255, 221, 220, 220)),
                                borderRadius: BorderRadius.circular(5.0)),
                          ]))
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  final style = TextStyle(
    color: Colors.grey[700],
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  Widget text;
  switch (value.toInt()) {
    case 0:
      text = Text('S', style: style);
      break;
    case 1:
      text = Text('M', style: style);
      break;
    case 2:
      text = Text('T', style: style);
      break;
    case 3:
      text = Text('W', style: style);
      break;
    case 4:
      text = Text('T', style: style);
      break;
    case 5:
      text = Text('F', style: style);
      break;
    case 6:
      text = Text('S', style: style);
      break;
    default:
      text = Text('', style: style);
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 8.0,
    child: text,
  );
}
