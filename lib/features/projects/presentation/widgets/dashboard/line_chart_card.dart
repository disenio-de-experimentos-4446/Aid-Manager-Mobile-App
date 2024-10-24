import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/projects/presentation/widgets/dashboard/line_titles_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LineChartCard extends StatelessWidget {

  final String projectId;

  const LineChartCard({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    final List<Color> gradientColors = [
      const Color.fromARGB(255, 57, 255, 116).withOpacity(0.10),
      const Color(0xff02d39a).withOpacity(0.10),
    ];

    final Gradient gradient = LinearGradient(
      colors: gradientColors,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

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
                    'Expected payments',
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
                          text: '\$90,324',
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.darkGreen,
                            letterSpacing: 1.05,
                          ),
                        ),
                        TextSpan(
                          text: '.87',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.normal,
                            color: const Color.fromARGB(139, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  context.go('/projects/$projectId/dashboard/edit-payments');
                },
                style: TextButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
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
          SizedBox(height: 30.0),
          SizedBox(
            height: 300.0,
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: 12,
                minY: 0,
                maxY: 6,
                titlesData: LineTitlesData.getTitleData(),
                gridData: FlGridData(
                  show: true,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: CustomColors.lightGreen,
                      strokeWidth: 2,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: CustomColors.lightGreen,
                      strokeWidth: 2,
                    );
                  },
                  drawVerticalLine: true,
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.black87, width: 1),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 3),
                      FlSpot(2, 2),
                      FlSpot(4, 4),
                      FlSpot(6, 2.5),
                      FlSpot(8, 4),
                      FlSpot(10.3, 3),
                      FlSpot(12, 4),
                    ],
                    isCurved: true,
                    color: const Color.fromARGB(255, 30, 143, 49),
                    barWidth: 2.5,
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: gradient,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
