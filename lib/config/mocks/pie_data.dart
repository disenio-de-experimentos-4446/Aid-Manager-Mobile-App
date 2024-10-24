import 'package:flutter/material.dart';

class PieData {
  static List<Data> pieData = [
    Data(name: 'To do', percent: 25, color: Color.fromARGB(255, 216, 66, 55)),
    Data(name: 'Progress', percent: 30, color: Color.fromARGB(255, 236, 218, 48)),
    Data(name: 'Done', percent: 45, color: Color.fromARGB(255, 58, 138, 61)),
  ];
}

class Data {
  final String name;

  final double percent;

  final Color color;

  Data({required this.name, required this.percent, required this.color});
}
