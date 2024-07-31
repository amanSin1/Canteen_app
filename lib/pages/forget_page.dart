import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPage extends StatefulWidget {
  const ForgetPage({super.key});

  @override
  State<ForgetPage> createState() => _ForgotState();
}

class _ForgotState extends State<ForgetPage> {
  TextEditingController email = TextEditingController();

  reset()async{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forget password"),
      ),
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: email,
              decoration: const InputDecoration(
                hintText: "Enter email",
              ),
            ),
            ElevatedButton(onPressed: (() => reset()), child: const Text("Send Link"))
          ],
        ),
      ),
    );
  }
}