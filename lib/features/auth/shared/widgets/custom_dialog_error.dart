import 'package:aidmanager_mobile/features/auth/shared/widgets/invalid_email_dialog.dart';
import 'package:aidmanager_mobile/features/auth/shared/widgets/is_empty_dialog.dart';
import 'package:aidmanager_mobile/features/auth/presentation/widgets/login/dialog/login_error_dialog.dart';
import 'package:aidmanager_mobile/features/auth/presentation/widgets/register/dialog/error_register_user_dialog.dart';
import 'package:aidmanager_mobile/features/auth/presentation/widgets/register/dialog/invalid_code_access_dialog.dart';
import 'package:aidmanager_mobile/features/auth/shared/exceptions/login_exceptions.dart';
import 'package:aidmanager_mobile/features/auth/shared/exceptions/register_exceptions.dart';
import 'package:flutter/material.dart';

// devuelve un wighet(Dialog) basado en el exception capturada en el catch
Widget getErrorDialog(BuildContext context, Exception e) {
  if (e is EmptyFieldsException) {
    return const IsEmptyDialog();
  } 
  else if (e is InvalidEmailFormatException) {
    return const InvalidEmailDialog();
  } 
  else if (e is InvalidCodeAccessException) {
    return const InvalidCodeAccessDialog();
  } 
  else if(e is SignUpFailedException){ 
    return const ErrorRegisterUserDialog();
  }
  else if (e is SignInFailedException) {
    print("ERROR DE SIGN IN  ${e}");
    return const LoginErrorDialog();
  } 
  else {
    return AlertDialog(
      title: const Text('Error'),
      content: const Text('An unknown error occurred D:'),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
void showErrorDialog(BuildContext context, Widget dialog) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return dialog;
    },
  );
}