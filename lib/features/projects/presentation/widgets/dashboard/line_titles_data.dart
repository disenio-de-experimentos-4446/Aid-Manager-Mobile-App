import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LineTitlesData {
  static getTitleData() => FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 35,
            getTitlesWidget: (value, meta) {
              TextStyle style = TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(204, 0, 0, 0),
              );

              Widget text;
              switch (value.toInt()) {
                case 1:
                  text = Text('3k', style: style, textAlign: TextAlign.center);
                  break;
                case 3:
                  text = Text('5k', style: style, textAlign: TextAlign.center);
                  break;
                case 5:
                  text = Text('10k', style: style, textAlign: TextAlign.center);
                  break;
                default:
                  text = Text('', style: style, textAlign: TextAlign.center);
                  break;
              }

              return SideTitleWidget(
                axisSide: meta.axisSide,
                space: 8.0, // Espacio entre el título y el eje
                child: text, // Centrar el texto
              );
            },
          )
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: (value, meta) {
              TextStyle style = TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(204, 0, 0, 0),
              );

              Widget text;
              switch (value.toInt()) {
                case 2:
                  text = Text('MAR', style: style, textAlign: TextAlign.center);
                  break;
                case 6:
                  text = Text('JUN', style: style, textAlign: TextAlign.center);
                  break;
                case 10:
                  text = Text('SEP', style: style, textAlign: TextAlign.center);
                  break;
                default:
                  text = Text('', style: style, textAlign: TextAlign.center);
                  break;
              }
              return SideTitleWidget(
                axisSide: meta.axisSide,
                space: 8.0, // Espacio entre el título y el eje
                child: text, // Centrar el texto
              );
            },
          ),
        ),
      );
}
