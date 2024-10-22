import 'package:flutter/material.dart';

class LoginErrorDialog extends StatelessWidget {
  const LoginErrorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 72,
          ),
          SizedBox(height: 20),
          Text(
            'Login Failed',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: const Text(
        'The credentials are not valid.\nPlease try again.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, height: 1.65),
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
