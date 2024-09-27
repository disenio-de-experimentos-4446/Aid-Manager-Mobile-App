import 'package:flutter/material.dart';

class InvalidEmailDialog extends StatelessWidget {
  const InvalidEmailDialog({super.key});

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
                Icons.mail,
                color: Color.fromARGB(255, 44, 44, 44),
                size: 72,
              ),
              Positioned(
                right: 0,
                bottom: 3,
                child: Icon(
                  Icons.cancel,
                  color: Color.fromARGB(255, 241, 99, 88),
                  size: 30,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Invalid Email',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: const Text(
        'The email you entered is not valid.\nPlease try again.',
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