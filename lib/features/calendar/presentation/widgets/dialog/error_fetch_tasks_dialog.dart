import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorFetchTasksDialog extends StatelessWidget {
  const ErrorFetchTasksDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.cancel,
            color: Colors.red,
            size: 72,
          ),
          SizedBox(height: 20),
          Text(
            'Error Fetching Tasks',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: const Text(
        'There was an error fetching the tasks.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, height: 1.65),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            context.go('/projects');
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