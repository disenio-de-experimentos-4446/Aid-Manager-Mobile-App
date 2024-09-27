import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AccessCodeTeamDialog extends StatefulWidget {
  const AccessCodeTeamDialog({super.key});

  @override
  State<AccessCodeTeamDialog> createState() => _AccessCodeTeamDialogState();
}

class _AccessCodeTeamDialogState extends State<AccessCodeTeamDialog> {

  final TextEditingController accessCodeController = TextEditingController();

  void onConfirmCode(accessCode) {

    if(accessCode == "macum") {
      context.go('/tutorial');
    }

  }

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.lock_person_rounded,
              color: Color.fromARGB(255, 61, 61, 61), size: 72),
          SizedBox(height: 20),
          Text(
            textAlign: TextAlign.center,
            'Access code is required for team member register',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, height: 1.5),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Enter the organization access code',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: accessCodeController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Access Code',
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
            final accessCode = accessCodeController.text;
            onConfirmCode(accessCode.trim());
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