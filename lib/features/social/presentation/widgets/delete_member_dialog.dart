import 'package:flutter/material.dart';

class DeleteMemberDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const DeleteMemberDialog({super.key, required this.onConfirm});

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
            size: 54.0,
          ),
          SizedBox(height: 16.0),
          Text(
            'Eliminar Miembro',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      content: Text(
        '¿Estás seguro de que deseas eliminar a este miembro?\n\nEsta acción es irreversible y se eliminará toda su información relevante dentro de la compañía.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16.0),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(
            'Cancelar',
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        ElevatedButton(
          onPressed: onConfirm,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: Text(
            'Eliminar',
            style: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ),
      ],
    );
  }
}