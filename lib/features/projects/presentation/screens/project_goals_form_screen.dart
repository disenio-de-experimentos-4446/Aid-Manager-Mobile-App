import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/auth/shared/widgets/is_empty_dialog.dart';
import 'package:aidmanager_mobile/features/projects/domain/entities/goals_chart.dart';
import 'package:aidmanager_mobile/features/projects/presentation/providers/dashboard_provider.dart';
import 'package:aidmanager_mobile/features/projects/presentation/widgets/dashboard/dialog/successfully_goals_chart_update_dialog.dart';
import 'package:aidmanager_mobile/features/projects/shared/widgets/custom_error_dashboard_dialog.dart';
import 'package:aidmanager_mobile/shared/helpers/show_customize_dialog.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';
import 'package:provider/provider.dart';

class ProjectGoalsFormScreen extends StatefulWidget {
  static const String name = "project_goals_form_screen";
  final String projectId;
  final String projectName;
  final List<double> weeklySummary;

  const ProjectGoalsFormScreen({
    super.key,
    required this.projectId,
    required this.projectName,
    required this.weeklySummary,
  });

  @override
  State<ProjectGoalsFormScreen> createState() => _ProjectGoalsFormScreenState();
}

class _ProjectGoalsFormScreenState extends State<ProjectGoalsFormScreen> {
  final List<TextEditingController> _controllers = List.generate(
    7,
    (_) => TextEditingController(),
  );

  Future<void> onSubmitUpdateGoalsGraph() async {
    bool allFieldsFilled =
        _controllers.every((controller) => controller.text.isNotEmpty);

    if (!allFieldsFilled) {
      showCustomizeDialog(context, const IsEmptyDialog());
      return;
    }

    final goalsChartData = GoalsChart(
      sunAmmount: int.parse(_controllers[0].text),
      monAmmount: int.parse(_controllers[1].text),
      tueAmmount: int.parse(_controllers[2].text),
      wedAmmount: int.parse(_controllers[3].text),
      thuAmmount: int.parse(_controllers[4].text),
      friAmmount: int.parse(_controllers[5].text),
      satAmmount: int.parse(_controllers[6].text),
    );

    final dashboardProvider = context.read<DashboardProvider>();

    try {
      await dashboardProvider.updateGoalsChartByProjectId(
          int.parse(widget.projectId), goalsChartData);

      if (!mounted) return;

      showCustomizeDialog(
        context,
        SuccessfullyGoalsChartUpdateDialog(
          projectId: widget.projectId,
          projectName: widget.projectName,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      final dialog = getDashboardErrorDialog(context, e as Exception);
      showErrorDialog(context, dialog);
    }
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _controllers.length; i++) {
      _controllers[i].text = widget.weeklySummary[i].toInt().toString();
    }
  }

  void _updateWeeklySummary() {
    setState(() {
      for (int i = 0; i < _controllers.length; i++) {
        final double? value = double.tryParse(_controllers[i].text);
        if (value != null && value >= 0 && value <= 100) {
          widget.weeklySummary[i] = value;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('El valor debe estar entre 0 y 100'),
            ),
          );

          return;
        }
      }
    });
  }

  void _generateRandomValues() {
    final randomNumber = Random();

    setState(() {
      for (var i = 0; i < _controllers.length; i++) {
        int randomValue = randomNumber.nextInt(100) + 1;
        _controllers[i].text = randomValue.toString();
      }
      _updateWeeklySummary();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: CustomColors.darkGreen,
          centerTitle: false,
          title: Text(
            widget.projectName,
            style: TextStyle(
              fontSize: 22.0,
              color: const Color.fromARGB(255, 255, 255, 255),
              letterSpacing: 0.55,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              context.go(
                  '/projects/${widget.projectId}/dashboard?name=${Uri.encodeComponent(widget.projectName)}');
            },
          ),
          toolbarHeight: 70.0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Expected Payments',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      for (var controller in _controllers) {
                        controller.clear();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: Text(
                      'Clear',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Column(
                children: [
                  for (int i = 0; i < _controllers.length; i += 2)
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              TextField(
                                controller: _controllers[i],
                                decoration: InputDecoration(
                                  labelText: 'Day ${i + 1}',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(height: 12.0),
                            ],
                          ),
                        ),
                        if (i + 1 < _controllers.length) SizedBox(width: 12.0),
                        if (i + 1 < _controllers.length)
                          Expanded(
                            child: Column(
                              children: [
                                TextField(
                                  controller: _controllers[i + 1],
                                  decoration: InputDecoration(
                                    labelText: 'Day ${i + 2}',
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                                SizedBox(height: 12.0),
                              ],
                            ),
                          ),
                      ],
                    ),
                ],
              ),
              SizedBox(height: 15.0),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _updateWeeklySummary,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                      ),
                      child: Text(
                        'Preview Graph',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onSubmitUpdateGoalsGraph,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                      ),
                      child: Text(
                        'Update Graph',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
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
                            reservedSize: 30.0,
                          ),
                        ),
                      ),
                      barGroups:
                          List.generate(widget.weeklySummary.length, (i) {
                        return BarChartGroupData(
                          x: i,
                          barRods: [
                            BarChartRodData(
                              toY: widget.weeklySummary[i],
                              color: Colors.green,
                              width: 15,
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                toY: 100,
                                color: const Color.fromARGB(255, 221, 220, 220),
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // BOLITA 8 (NO BORRAR (NO FUNCIONA LA APP SI BORRAS))
        floatingActionButton: FloatingActionButton(
          onPressed: _generateRandomValues,
          backgroundColor: const Color.fromARGB(255, 214, 214, 214),
          child: BounceInUp(
            animate: true,
            duration: Duration(milliseconds: 1500),
            child: SizedBox(
              width: 45.0,
              height: 45.0,
              child: Image.asset('assets/images/bolita8.png'),
            ),
          ),
        ),
      ),
    );
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  final style = TextStyle(
    color: CustomColors.fieldGrey,
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
    child: text,
  );
}
