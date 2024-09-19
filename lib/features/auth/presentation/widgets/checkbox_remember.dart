import 'package:flutter/material.dart';

class RememberCheckbox extends StatefulWidget {
  const RememberCheckbox({super.key});

  @override
  RemeberCheckboxState createState() => RemeberCheckboxState();
}

class RemeberCheckboxState extends State<RememberCheckbox> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(-10, 0),
      child: Row(
        children: [
          Checkbox(
            activeColor: Colors.green[700],
            value: _isChecked,
            onChanged: (bool? value) {
              setState(() {
                _isChecked = value ?? false;
              });
            },
          ),
          const Text(
            'Remember me',
            style: TextStyle(fontSize: 17),
          ),
        ],
      ),
    );
  }
}