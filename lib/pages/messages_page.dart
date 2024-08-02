import 'package:flutter/material.dart';

class MessagesPage extends StatelessWidget {
  final String cardTitle;
  final String cardImagePath;

   MessagesPage({super.key, required this.cardTitle, required this.cardImagePath});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            cardImagePath, // Ensure this is not an empty string
            height: 90.0,
            width: 90.0,
          ),
          SizedBox(height: 20),
          Text(
            cardTitle,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text("This is the Messages page with information about $cardTitle."),
        ],
      ),
    );
  }
}
