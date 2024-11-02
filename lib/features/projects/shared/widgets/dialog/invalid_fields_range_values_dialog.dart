import 'package:flutter/material.dart';

class InvalidFieldsRangeValuesDialog extends StatelessWidget {
  const InvalidFieldsRangeValuesDialog({super.key});

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
            'Invalid Field Values',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: const Text(
        'The values of the fields must be between 0 and 6.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, height: 1.65),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
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