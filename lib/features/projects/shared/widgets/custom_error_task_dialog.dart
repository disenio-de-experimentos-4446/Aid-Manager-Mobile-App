import 'package:aidmanager_mobile/features/projects/presentation/widgets/tasks/dialog/error_task_creation_dialog.dart';
import 'package:aidmanager_mobile/features/projects/presentation/widgets/tasks/dialog/task_loading_error_dialog.dart';
import 'package:aidmanager_mobile/features/projects/shared/exceptions/task_exceptions.dart';
import 'package:flutter/material.dart';

// devuelve un wighet(Dialog) basado en el exception capturada en el catch
Widget getProjectErrorDialog(BuildContext context, Exception e) {
  if (e is TasksFetchByProjectException) {
    return const TaskLoadingErrorDialog();
  } 
  else if (e is TaskCreationException) {
    return const ErrorTaskCreationDialog();
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