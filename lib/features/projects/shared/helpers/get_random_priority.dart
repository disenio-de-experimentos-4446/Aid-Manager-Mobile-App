import 'package:flutter/material.dart';

String getPriorityFromDueDate(DateTime dueDate) {
  final now = DateTime.now();
  final difference = dueDate.difference(now).inDays;

  if (difference <= 7) {
    return 'High';
  } else if (difference <= 14) {
    return 'Medium';
  } else if (difference <= 21) {
    return 'Low';
  } else {
    return 'Low';
  }
}

Color getPriorityColor(String priority) {
  switch (priority) {
    case 'High':
      return Color.fromARGB(255, 224, 64, 64); // Rojo
    case 'Medium':
      return Color.fromARGB(255, 255, 193, 7); // Amarillo
    case 'Low':
      return Color.fromARGB(255, 76, 175, 80); // Verde
    default:
      return Color.fromARGB(255, 158, 158, 158); // Gris por defecto
  }
}
