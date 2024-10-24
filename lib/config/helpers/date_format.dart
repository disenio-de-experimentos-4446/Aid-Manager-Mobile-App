import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


String formatTimeOfDay(TimeOfDay time) {
  final now = DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
  final format = DateFormat('HH:mm:ss');
  return format.format(dt);
}

int parseHour(String hourString, String period) {
  int hour = int.tryParse(hourString) ?? 0;
  if (period.toLowerCase() == 'pm' && hour != 12) {
    hour += 12;
  } else if (period.toLowerCase() == 'am' && hour == 12) {
    hour = 0;
  }
  return hour;
}