import 'package:flutter/material.dart';

class ConfirmTaskDeleteDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const ConfirmTaskDeleteDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.warning,
            color: Colors.red,
            size: 72,
          ),
          SizedBox(height: 20),
          Text(
            'Delete Task',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: const Text(
        'Are you sure you want to delete this task?\nThis action is irreversible.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, height: 1.65),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(fontSize: 18),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // Color de fondo del botón "Delete"
          ),
          child: const Text(
            'Delete',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ],
    );
  }
}