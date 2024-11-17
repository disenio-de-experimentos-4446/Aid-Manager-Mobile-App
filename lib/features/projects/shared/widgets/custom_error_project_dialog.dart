import 'package:aidmanager_mobile/features/projects/presentation/widgets/project/dialog/error_project_creation_dialog.dart';
import 'package:aidmanager_mobile/features/projects/presentation/widgets/project/dialog/error_update_project_dialog.dart';
import 'package:aidmanager_mobile/features/projects/presentation/widgets/project/dialog/invalid_description_length_dialog.dart';
import 'package:aidmanager_mobile/features/projects/presentation/widgets/project/dialog/invalid_images_lenght_dialog.dart';
import 'package:aidmanager_mobile/features/projects/shared/exceptions/project_exceptions.dart';
import 'package:flutter/material.dart';

// devuelve un wighet(Dialog) basado en el exception capturada en el catch
Widget getProjectErrorDialog(BuildContext context, Exception e) {
  if (e is ProjectCreationException) {
    return const ProjectCreationErrorDialog();
  } 
  else if (e is InvalidDescriptionLengthException) {
    return const InvalidDescriptionLengthDialog();
  } 
  else if (e is InvalidNumberOfImagesException) {
    return const InvalidImagesLenghtDialog();
  }
  else if(e is ProjectUpdateException) {
      return const ErrorUpdateProjectDialog();
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