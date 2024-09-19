import 'package:flutter/material.dart';

class LoginFacebookButton extends StatelessWidget {
  const LoginFacebookButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton.icon(
        onPressed: () {
          // Acción a realizar cuando se presiona el botón de Facebook
        },
        icon: const Icon(Icons.facebook, color: Colors.blue),
        label: const Text(
          'Facebook',
          style: TextStyle(color: Colors.blue, fontSize: 18),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.blue),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        ),
      ),
    );
  }
}
