import 'package:flutter/material.dart';

class LoginGoggleButton extends StatelessWidget {
  const LoginGoggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton.icon(
        onPressed: () {
          // Acción a realizar cuando se presiona el botón de Google
        },
        icon: Image.asset(
          'assets/images/google-icon.webp', // Ruta de la imagen del logo de Google
          height: 24.0, // Ajusta el tamaño según sea necesario
        ),
        label: const Text(
          'Google',
          style: TextStyle(color: Colors.red, fontSize: 18),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.red),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        ),
      ),
    );
  }
}
