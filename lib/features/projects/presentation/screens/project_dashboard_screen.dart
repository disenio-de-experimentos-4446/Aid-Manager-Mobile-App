import 'package:aidmanager_mobile/config/mocks/pie_data.dart';
import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/projects/presentation/widgets/dashboard/bar_chart_card.dart';
import 'package:aidmanager_mobile/features/projects/presentation/widgets/dashboard/line_chart_card.dart';
import 'package:aidmanager_mobile/features/projects/presentation/widgets/dashboard/pie_chart_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProjectDashboardScreen extends StatefulWidget {
  static const String name = "project_dashboard_screen";
  final String projectId;
  final String projectName;

  const ProjectDashboardScreen({
    super.key,
    required this.projectId,
    required this.projectName,
  });

  @override
  State<ProjectDashboardScreen> createState() => _ProjectDashboardScreenState();
}

class _ProjectDashboardScreenState extends State<ProjectDashboardScreen> {
  List<bool> isSelected = [true, false];

  List<PieChartSectionData> getSections() => PieData.pieData
      .asMap()
      .map<int, PieChartSectionData>((index, data) {
        final radius = 50.0 + (data.percent / 100) * 60.0;
        final fontSize = 16.0 + (data.percent / 100) * 25.0;
        final value = PieChartSectionData(
          color: data.color,
          value: data.percent,
          title: '${data.percent}%',
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          radius: radius,
        );
        return MapEntry(index, value);
      })
      .values
      .toList();

  List<double> weeklySummary = [
    35.75,
    42.50,
    58.20,
    63.40,
    77.10,
    84.25,
    91.60,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.lightGrey,
      appBar: AppBar(
        backgroundColor: CustomColors.darkGreen,
        centerTitle: false,
        title: Text(
          widget.projectName,
          style: TextStyle(
            fontSize: 22.0,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            context.go('/projects/${widget.projectId}');
          },
        ),
        toolbarHeight: 70.0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_horiz,
              color: Colors.white,
              size: 32.0,
            ),
            onPressed: () {
              // Acción al presionar el ícono de tres puntos
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Statistics',
                    style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.05),
                  ),
                  ToggleButtons(
                    isSelected: isSelected,
                    onPressed: (int index) {
                      setState(() {
                        for (int i = 0; i < isSelected.length; i++) {
                          isSelected[i] = i == index;
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(30.0),
                    selectedBorderColor: CustomColors.darkGreen,
                    selectedColor: Colors.white,
                    fillColor: CustomColors.darkGreen,
                    borderColor: CustomColors.darkGreen,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Weekly',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: isSelected[0]
                                ? Colors.white
                                : CustomColors.darkGreen,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Monthly',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: isSelected[1]
                                ? Colors.white
                                : CustomColors.darkGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              PieChartCard(getSections: getSections()),
              SizedBox(
                height: 25,
              ),
              LineChartCard(
                projectId: widget.projectId,
              ),
              SizedBox(
                height: 25,
              ),
              BarChartCard(
                projectId: widget.projectId,
                summary: weeklySummary,
              )
            ],
          ),
        ),
      ),
    );
  }
}
