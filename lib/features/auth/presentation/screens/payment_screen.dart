import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {

  static const name = 'payment_screen';

  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Align(alignment: Alignment.center, child: Text('Payment Content')),
    );
  }
}
