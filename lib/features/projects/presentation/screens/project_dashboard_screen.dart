import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/auth/presentation/providers/auth_provider.dart';
import 'package:aidmanager_mobile/features/projects/presentation/providers/dashboard_provider.dart';
import 'package:aidmanager_mobile/features/projects/presentation/widgets/dashboard/bar_chart_card.dart';
import 'package:aidmanager_mobile/features/projects/presentation/widgets/dashboard/line_chart_card.dart';
import 'package:aidmanager_mobile/features/projects/presentation/widgets/dashboard/pie_chart_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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

  List<PieChartSectionData> getSections(
      double donePercentage, double progressPercentage, double toDoPercentage) {
    return [
      PieChartSectionData(
        color: Colors.green,
        value: donePercentage,
        title: '${donePercentage.toStringAsFixed(1)}%',
        titleStyle: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        radius: 50.0 + (donePercentage / 100) * 60.0,
      ),
      PieChartSectionData(
        color: Colors.blue,
        value: progressPercentage,
        title: '${progressPercentage.toStringAsFixed(1)}%',
        titleStyle: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        radius: 50.0 + (progressPercentage / 100) * 60.0,
      ),
      PieChartSectionData(
        color: Colors.red,
        value: toDoPercentage,
        title: '${toDoPercentage.toStringAsFixed(1)}%',
        titleStyle: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        radius: 50.0 + (toDoPercentage / 100) * 60.0,
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _loadDashboardInformation();
  }

  Future<void> _loadDashboardInformation() async {
    final projectId = int.parse(widget.projectId);
    final dashboardRepository =
        Provider.of<DashboardProvider>(context, listen: false);

    await dashboardRepository.getDashboardInformationByProjectId(projectId);
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<AuthProvider>(context).user;
    final dashboardRepository = context.watch<DashboardProvider>();
    final doneTasksCount =
        dashboardRepository.tasks.where((task) => task.state == 'Done').length;
    final progressTasksCount = dashboardRepository.tasks
        .where((task) => task.state == 'Progress')
        .length;
    final toDoTasksCount =
        dashboardRepository.tasks.where((task) => task.state == 'ToDo').length;

    int totalTasks = doneTasksCount + progressTasksCount + toDoTasksCount;

    double donePercentage =
        totalTasks > 0 ? (doneTasksCount / totalTasks) * 100 : 0;
    double progressPercentage =
        totalTasks > 0 ? (progressTasksCount / totalTasks) * 100 : 0;
    double toDoPercentage =
        totalTasks > 0 ? (toDoTasksCount / totalTasks) * 100 : 0;

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
      body: dashboardRepository.initialLoading
          ? Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    strokeWidth: 8,
                    color: CustomColors.darkGreen,
                  ),
                ),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 25.0),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
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
                    PieChartCard(
                      projectId: widget.projectId,
                      projectName: widget.projectName,
                      isManager: currentUser!.role == 'Manager',
                      tasks: dashboardRepository.tasks,
                      getSections: getSections(
                        donePercentage,
                        progressPercentage,
                        toDoPercentage,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    LineChartCard(
                      projectId: widget.projectId,
                      isManager: currentUser.role == 'Manager',
                      projectName: widget.projectName,
                      amountSummary: [
                        (dashboardRepository.projectDashboard?.linesChartBarData
                                    .isNotEmpty ??
                                false)
                            ? dashboardRepository
                                .projectDashboard!.linesChartBarData[0].data1
                                .toDouble()
                            : 0.0,
                        (dashboardRepository.projectDashboard?.linesChartBarData
                                    .isNotEmpty ??
                                false)
                            ? dashboardRepository
                                .projectDashboard!.linesChartBarData[0].data2
                                .toDouble()
                            : 0.0,
                        (dashboardRepository.projectDashboard?.linesChartBarData
                                    .isNotEmpty ??
                                false)
                            ? dashboardRepository
                                .projectDashboard!.linesChartBarData[0].data3
                                .toDouble()
                            : 0.0,
                        (dashboardRepository.projectDashboard?.linesChartBarData
                                    .isNotEmpty ??
                                false)
                            ? dashboardRepository
                                .projectDashboard!.linesChartBarData[0].data4
                                .toDouble()
                            : 0.0,
                        (dashboardRepository.projectDashboard?.linesChartBarData
                                    .isNotEmpty ??
                                false)
                            ? dashboardRepository
                                .projectDashboard!.linesChartBarData[0].data5
                                .toDouble()
                            : 0.0,
                        (dashboardRepository.projectDashboard?.linesChartBarData
                                    .isNotEmpty ??
                                false)
                            ? dashboardRepository
                                .projectDashboard!.linesChartBarData[0].data6
                                .toDouble()
                            : 0.0,
                        (dashboardRepository.projectDashboard?.linesChartBarData
                                    .isNotEmpty ??
                                false)
                            ? dashboardRepository
                                .projectDashboard!.linesChartBarData[0].data7
                                .toDouble()
                            : 0.0,
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    BarChartCard(
                      projectId: widget.projectId,
                      isManager: currentUser.role == 'Manager',
                      projectName: widget.projectName,
                      summary: [
                        (dashboardRepository
                                    .projectDashboard?.barData.isNotEmpty ??
                                false)
                            ? dashboardRepository
                                .projectDashboard!.barData[0].sunAmmount
                                .toDouble()
                            : 0.0,
                        (dashboardRepository
                                    .projectDashboard?.barData.isNotEmpty ??
                                false)
                            ? dashboardRepository
                                .projectDashboard!.barData[0].monAmmount
                                .toDouble()
                            : 0.0,
                        (dashboardRepository
                                    .projectDashboard?.barData.isNotEmpty ??
                                false)
                            ? dashboardRepository
                                .projectDashboard!.barData[0].tueAmmount
                                .toDouble()
                            : 0.0,
                        (dashboardRepository
                                    .projectDashboard?.barData.isNotEmpty ??
                                false)
                            ? dashboardRepository
                                .projectDashboard!.barData[0].wedAmmount
                                .toDouble()
                            : 0.0,
                        (dashboardRepository
                                    .projectDashboard?.barData.isNotEmpty ??
                                false)
                            ? dashboardRepository
                                .projectDashboard!.barData[0].thuAmmount
                                .toDouble()
                            : 0.0,
                        (dashboardRepository
                                    .projectDashboard?.barData.isNotEmpty ??
                                false)
                            ? dashboardRepository
                                .projectDashboard!.barData[0].friAmmount
                                .toDouble()
                            : 0.0,
                        (dashboardRepository
                                    .projectDashboard?.barData.isNotEmpty ??
                                false)
                            ? dashboardRepository
                                .projectDashboard!.barData[0].satAmmount
                                .toDouble()
                            : 0.0,
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
