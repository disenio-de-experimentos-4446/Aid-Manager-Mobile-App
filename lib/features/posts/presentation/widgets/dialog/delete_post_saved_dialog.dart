import 'package:flutter/material.dart';

class DeletePostSavedDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const DeletePostSavedDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.warning_rounded,
            color: Colors.red,
            size: 60.0,
          ),
          SizedBox(height: 16.0),
          Text(
            'Remove Saved Post',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      content: Text(
        'Are you sure you want to remove this post from your saved posts?',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16.0),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(
            'Cancel',
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        ElevatedButton(
          onPressed: onConfirm,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: Text(
            'Remove',
            style: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ),
      ],
    );
  }
}