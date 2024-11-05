import 'package:aidmanager_mobile/features/profile/presentation/widgets/dialog/error_update_profile_image.dart';
import 'package:aidmanager_mobile/features/profile/presentation/widgets/dialog/error_update_user_information.dart';
import 'package:aidmanager_mobile/features/profile/shared/exceptions/profile_exception.dart';
import 'package:flutter/material.dart';

// devuelve un widget(Dialog) basado en la excepción capturada en el catch
Widget getProfileErrorDialog(BuildContext context, Exception e) {
  if (e is UserProfileUpdateFailedException) {
    return const ErrorUpdateProfileImageDialog();
  }
  else if (e is ImageUploadFailedException) {
    return const ErrorUpdateUserInformationDialog();
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