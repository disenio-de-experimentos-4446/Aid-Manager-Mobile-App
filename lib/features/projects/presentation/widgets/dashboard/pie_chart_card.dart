import 'package:aidmanager_mobile/config/mocks/pie_data.dart';
import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/projects/domain/entities/task.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PieChartCard extends StatelessWidget {
  final String projectId;
  final String projectName;
  final bool isManager;
  final List<Task> tasks;
  final List<PieChartSectionData> getSections;

  const PieChartCard({
    super.key,
    required this.getSections,
    required this.tasks,
    required this.projectId,
    required this.projectName,
    required this.isManager,
  });

  @override
  Widget build(BuildContext context) {
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
                    'Tasks progress',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              '${tasks.where((task) => task.state == 'Done').length}',
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.darkGreen,
                          ),
                        ),
                        TextSpan(
                          text: '/${tasks.length} tasks completed',
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
              Row(
                children: [
                  Icon(
                    Icons.arrow_upward,
                    color: Colors.green,
                    size: 30.0,
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    tasks.isEmpty
                        ? '0.0%'
                        : '${(tasks.where((task) => task.state == 'Done').length / tasks.length * 100).toStringAsFixed(1)}%',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 30.0),
          Center(
            child: SizedBox(
              width: 300.0,
              height: 300.0,
              child: tasks.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.assignment_late,
                            size: 54, color: Colors.grey),
                        SizedBox(height: 15),
                        Text(
                          'No tasks available',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                        if (isManager) ...[
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              context.go(
                                  '/projects/$projectId/tasks?name=${Uri.encodeComponent(projectName)}');
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.green,
                              backgroundColor: CustomColors.lightGreen,
                            ),
                            child: Text(
                              'Create new task',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ],
                    )
                  : PieChart(
                      PieChartData(
                        sections: getSections,
                        sectionsSpace: 0,
                      ),
                    ),
            ),
          ),
          SizedBox(height: 35.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: PieData.pieData.map((data) {
              return Row(
                children: [
                  Container(
                    width: 16.0,
                    height: 16.0,
                    color: data.color,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    data.name,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
