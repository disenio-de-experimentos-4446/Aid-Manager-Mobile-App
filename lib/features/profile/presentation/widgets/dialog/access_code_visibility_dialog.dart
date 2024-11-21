import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AccessCodeVisibilityDialog extends StatefulWidget {
  const AccessCodeVisibilityDialog({super.key});

  @override
  State<AccessCodeVisibilityDialog> createState() => _AccessCodeVisibilityDialogState();
}

class _AccessCodeVisibilityDialogState extends State<AccessCodeVisibilityDialog> {
  final TextEditingController passwordController = TextEditingController();

  void onConfirmPassword(String password) {
    context.pop(password);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.lock_rounded,
              color: Color.fromARGB(255, 61, 61, 61), size: 72),
          SizedBox(height: 20),
          Text(
            textAlign: TextAlign.center,
            'Enter your password',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, height: 1.5),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Password is required to view the team code',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, height: 1.5),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(fontSize: 18),
          ),
        ),
        TextButton(
          onPressed: () {
            final password = passwordController.text;
            onConfirmPassword(password.trim());
          },
          child: const Text(
            'Confirm',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}