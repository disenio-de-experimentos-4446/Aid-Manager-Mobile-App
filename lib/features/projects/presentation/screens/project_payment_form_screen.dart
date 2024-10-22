import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/projects/presentation/widgets/dashboard/line_titles_data.dart';
import 'package:go_router/go_router.dart';

class ProjectPaymentFormScreen extends StatefulWidget {
  final String projectId;
  static const String name = "project_payment_form_screen";

  const ProjectPaymentFormScreen({super.key, required this.projectId});

  @override
  State<ProjectPaymentFormScreen> createState() =>
      _ProjectPaymentFormScreenState();
}

class _ProjectPaymentFormScreenState extends State<ProjectPaymentFormScreen> {
  final List<TextEditingController> _controllers = List.generate(
    7,
    (_) => TextEditingController(),
  );

  final List<FlSpot> _points = [
    FlSpot(0, 3),
    FlSpot(2, 2),
    FlSpot(4, 4),
    FlSpot(6, 2.5),
    FlSpot(8, 4),
    FlSpot(10, 3),
    FlSpot(12, 4)
  ];

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _updatePoints() {
    setState(() {
      for (int i = 0; i < _points.length; i++) {
        final double? y = double.tryParse(_controllers[i].text);
        if (y != null && y >= 0 && y <= 6) {
          _points[i] = FlSpot(_points[i].x, y);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('The value must be between 0 and 6'),
          ));

          return;
        }
      }
    });
  }

  void _generatePoints() {
    final randomNumber = Random();

    setState(() {
      for (var i = 0; i < _controllers.length; i++) {
        int randomValue = randomNumber
            .nextInt(6);
        _controllers[i].text =
            randomValue.toString();
      }
      _updatePoints();
    });
  }

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
                      _updatePoints();
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
                  for (int i = 0; i < _points.length; i += 2)
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              TextField(
                                controller: _controllers[i],
                                decoration: InputDecoration(
                                  labelText: 'Point N° ${_points[i].x}',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(height: 12.0),
                            ],
                          ),
                        ),
                        if (i + 1 < _points.length)
                          SizedBox(width: 12.0), // Espacio entre las columnas
                        if (i + 1 < _points.length)
                          Expanded(
                            child: Column(
                              children: [
                                TextField(
                                  controller: _controllers[i + 1],
                                  decoration: InputDecoration(
                                    labelText: 'Point N° ${_points[i + 1].x}',
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
                      onPressed: () {
                        _updatePoints();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor:
                            const Color.fromARGB(255, 59, 138, 202),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                      ),
                      child: Text(
                        'Preview Graph',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(width: 10), // Espacio entre los botones
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _updatePoints,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromARGB(255, 235, 69, 57),
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
                        spots: _points,
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
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _generatePoints();
          },
          backgroundColor: CustomColors.fieldGrey, // Color del botón flotante
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
