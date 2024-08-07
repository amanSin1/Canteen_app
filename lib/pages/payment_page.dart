import 'package:flutter/material.dart';
class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('payment'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: (){},
          style: ElevatedButton.styleFrom(

            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 15,
            ),
          ), child: const Text("Pay"),
        ),
      )
    );
  }
}
