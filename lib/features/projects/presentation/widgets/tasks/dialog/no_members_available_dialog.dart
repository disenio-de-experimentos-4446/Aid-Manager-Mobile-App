import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NoMembersAvailableDialog extends StatelessWidget {
  const NoMembersAvailableDialog({super.key});

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
                Icons.group,
                color: Color.fromARGB(255, 44, 44, 44),
                size: 72,
              ),
              Positioned(
                right: 0,
                bottom: 3,
                child: Icon(
                  Icons.cancel,
                  color: Colors.red,
                  size: 30,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'No Members Available',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, height: 1.5, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: const Text(
        'There are no members available in the company to assign tasks.\nPlease invite new members.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, height: 1.65),
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.go('/profile');
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