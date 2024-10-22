import 'package:flutter/material.dart';

class IsEmptyDialog extends StatelessWidget {
  const IsEmptyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.error_outline,
              color: Color.fromARGB(255, 218, 96, 96), size: 72),
          SizedBox(height: 20),
          Text(
            'Incomplete Form',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: const Text(
        'Please complete all fields',
        style: TextStyle(fontSize: 18),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
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
