import 'package:flutter/material.dart';

class AddressPageTextfield extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  AddressPageTextfield({super.key,required this.hintText, required this.controller,required this.obscureText});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        filled: false,
        fillColor: theme.colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: theme.colorScheme.primary),

        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
      ),
    );
  }
}
