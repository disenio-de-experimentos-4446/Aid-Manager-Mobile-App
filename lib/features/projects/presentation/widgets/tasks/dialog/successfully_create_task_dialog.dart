import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuccessfullyCreateTaskDialog extends StatelessWidget {
  final String projectId;
  final String projectName;

  const SuccessfullyCreateTaskDialog({super.key, required this.projectId, required this.projectName});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.task,
                color: Color.fromARGB(255, 44, 44, 44),
                size: 72,
              ),
              Positioned(
                right: 0,
                bottom: 3,
                child: Icon(
                  Icons.check_circle,
                  color: Color.fromARGB(255, 76, 175, 80),
                  size: 30,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Task Created Successfully',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: const Text(
        'The task has been\n created successfully.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, height: 1.65),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            context.go('/projects/$projectId/tasks?name=${Uri.encodeComponent(projectName)}');
          },
          child: const Text(
            'OK',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
