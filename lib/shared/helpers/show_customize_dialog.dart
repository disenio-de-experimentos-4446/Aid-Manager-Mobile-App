import 'package:flutter/material.dart';

void showCustomizeDialog(
  BuildContext context,
  Widget dialog,
) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return dialog;
    },
  );
}
