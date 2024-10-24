import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterSuccessfullyDialog extends StatelessWidget {
  const RegisterSuccessfullyDialog({super.key});

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
                Icons.person,
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
            'User Created Successfully',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: const Text(
        'The user has been created successfully.\nYou can now log in.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, height: 1.65),
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.go('/');
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