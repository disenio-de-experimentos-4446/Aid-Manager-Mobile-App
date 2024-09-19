import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  static const String name = "calendar_screen";

  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const CalendarContent(),
        );
      },
    );
  }
}

class CalendarContent extends StatelessWidget {
  const CalendarContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: const Center(
        child: Text(
          'Calendar Content',
          style: TextStyle(color: Colors.black, fontSize: 24.0),
        ),
      ),
    );
  }
}