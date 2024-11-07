import 'package:aidmanager_mobile/features/calendar/presentation/widgets/dialog/error_fetch_tasks_dialog.dart';
import 'package:aidmanager_mobile/features/calendar/presentation/widgets/dialog/no_tasks_in_company_dialog.dart';
import 'package:aidmanager_mobile/features/calendar/shared/exceptions/calendar_exception.dart';
import 'package:flutter/material.dart';

Widget getCalendarErrorDialog(BuildContext context, Exception e) {
  if (e is NoTasksInCompanyException) {
    return const NoTasksInCompanyDialog();
  } 
  else if (e is TasksFetchException) {
    return const ErrorFetchTasksDialog();
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