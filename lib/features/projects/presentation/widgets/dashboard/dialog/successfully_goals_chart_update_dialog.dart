import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuccessfullyGoalsChartUpdateDialog extends StatelessWidget {

  final String projectId;
  final String projectName;

  const SuccessfullyGoalsChartUpdateDialog({super.key, required this.projectId, required this.projectName});

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
                Icons.flag,
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
            'Goals Chart Updated Successfully',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: const Text(
        'The goals chart has been updated successfully.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, height: 1.65),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            context.go('/projects/$projectId/dashboard?name=${Uri.encodeComponent(projectName)}');
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