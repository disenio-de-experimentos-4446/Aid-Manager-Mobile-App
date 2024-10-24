import 'package:flutter/material.dart';

class PasswordsNotSameDialog extends StatelessWidget {
  const PasswordsNotSameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.warning,
              color: Color.fromARGB(255, 218, 218, 96), size: 72),
          SizedBox(height: 20),
          Text(
            'Passwords Do Not Match',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: const Text(
        textAlign: TextAlign.center,
        'The passwords you entered do not match. Please try again.',
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
