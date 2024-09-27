import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {

  final TextEditingController emailController;

  const EmailField({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(fontSize: 18.0),
      decoration: InputDecoration(
        filled: true,
        fillColor: CustomColors.fieldGrey,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: CustomColors.grey,
          ),
        ),
        hintText: 'Email Address',
        hintStyle: const TextStyle(fontSize: 18.0),
        suffixIcon: const Padding(
          padding: EdgeInsets.only(
              right: 18.0), // Ajusta el padding según sea necesario
          child: Icon(Icons.email_rounded, size: 28),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 18.0),
      ),
    );
  }
}
