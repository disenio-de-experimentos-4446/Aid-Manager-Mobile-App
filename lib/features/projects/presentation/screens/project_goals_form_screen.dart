import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class ProjectGoalsFormScreen extends StatefulWidget {
  static const String name = "project_goals_form_screen";
  final String projectId;

  const ProjectGoalsFormScreen({super.key, required this.projectId});

  @override
  State<ProjectGoalsFormScreen> createState() => _ProjectGoalsFormScreenState();
}

class _ProjectGoalsFormScreenState extends State<ProjectGoalsFormScreen> {
  final List<TextEditingController> _controllers = List.generate(
    7,
    (_) => TextEditingController(),
  );

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
  void initState() {
    super.initState();
    for (int i = 0; i < _controllers.length; i++) {
      _controllers[i].text = weeklySummary[i].toString();
    }
  }

  void _updateWeeklySummary() {
    setState(() {
      for (int i = 0; i < _controllers.length; i++) {
        final double? value = double.tryParse(_controllers[i].text);
        if (value != null && value >= 0 && value <= 100) {
          weeklySummary[i] = value;
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
            'Lonely Beach Pacific',
            style: TextStyle(
              fontSize: 22.0,
              color: const Color.fromARGB(255, 255, 255, 255),
              letterSpacing: 0.55,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              context.go('/projects/${widget.projectId}/dashboard');
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
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Expected Payments',
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      for (var controller in _controllers) {
                        controller.clear();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor:
                          Colors.white, // Color del texto del botón
                      backgroundColor: Colors.green, // Color del botón
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            12.0), // Aumentar el border radius
                      ),
                    ),
                    child: Text(
                      'Clear Fields',
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
                        if (i + 1 < _controllers.length)
                          SizedBox(width: 12.0), // Espacio entre las columnas
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
                                SizedBox(
                                    height:
                                        12.0), // Espacio entre los TextFields
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
                        'Update Graph',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(width: 10), // Espacio entre los botones
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _generateRandomValues,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                      ),
                      child: Text(
                        'Randomize',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
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
                      barGroups: List.generate(weeklySummary.length, (i) {
                        return BarChartGroupData(
                          x: i,
                          barRods: [
                            BarChartRodData(
                              toY: weeklySummary[i],
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
        floatingActionButton: FloatingActionButton(
          onPressed: _generateRandomValues,
          backgroundColor: const Color.fromARGB(255, 214, 214, 214), // Color del botón flotante
          child: BounceInUp(
            animate: true,
            duration: Duration(milliseconds: 1500),
            child: SizedBox(
              width: 45.0, // Ancho deseado
              height: 45.0, // Alto deseado
              child: Image.asset('assets/images/bolita8.png'), // Imagen local
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
