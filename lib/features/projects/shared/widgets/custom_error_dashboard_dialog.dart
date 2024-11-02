import 'package:aidmanager_mobile/features/projects/presentation/widgets/dashboard/dialog/error_get_dashboard_information_dialog.dart';
import 'package:aidmanager_mobile/features/projects/presentation/widgets/dashboard/dialog/error_update_goals_chart_dialog.dart';
import 'package:aidmanager_mobile/features/projects/presentation/widgets/dashboard/dialog/error_update_payment_chart_dialog.dart';
import 'package:aidmanager_mobile/features/projects/shared/exceptions/dashboard_exceptions.dart';
import 'package:flutter/material.dart';

// devuelve un widget(Dialog) basado en la excepción capturada en el catch
Widget getDashboardErrorDialog(BuildContext context, Exception e) {
  if (e is DashboardFetchByProjectException) {
    return const ErrorGetDashboardInformationDialog();
  } 
  else if (e is AmountChartCreationException) {
    return const ErrorUpdatePaymentChartDialog();
  } 
  else if (e is GoalsChartCreationException) {
    return const ErrorUpdateGoalsChartDialog();
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