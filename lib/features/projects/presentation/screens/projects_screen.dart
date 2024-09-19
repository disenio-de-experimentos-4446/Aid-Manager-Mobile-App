import 'package:flutter/material.dart';

class ProjectsScreen extends StatelessWidget {
  static const String name = "projects_screen";

  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const ProjectsContent(),
        );
      },
    );
  }
}

class ProjectsContent extends StatelessWidget {
  const ProjectsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
      ),
      body: const Center(
        child: Text(
          'Projects Content',
          style: TextStyle(color: Colors.black, fontSize: 24.0),
        ),
      ),
    );
  }
}