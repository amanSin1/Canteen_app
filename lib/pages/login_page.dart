import 'package:canteen_app/pages/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

import '../my_textfield.dart';
import 'forget_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Get.snackbar("Success", "You have successfully signed in!",
          snackPosition: SnackPosition.BOTTOM);
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'invalid-email':
          message = "The email address is not valid.";
          break;
        case 'user-disabled':
          message = "The user has been disabled.";
          break;
        case 'user-not-found':
          message = "No user found for that email.";
          break;
        case 'wrong-password':
          message = "Incorrect password.";
          break;
        default:
          message = "An unexpected error occurred. Please try again.";
      }
      Get.snackbar("Error", message, snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error", "An unknown error occurred. Please try again.",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            const Center(

              child: Text("Sign in to your food court",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 15),
            MyTextfield(
              hintText: "Email",
              controller: _emailController,
              obscureText: false,
            ),
            SizedBox(height: 15),
            MyTextfield(
              hintText: "Password",
              controller: _passwordController,
              obscureText: true,
            ),


            SizedBox(height: 5),
            Row(
              children: [
                Spacer(),
                TextButton(
                  onPressed: () => Get.to(() => ForgetPage()), // Navigate to ForgetPage
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.teal,
                    textStyle: TextStyle(fontSize: 16.0),
                  ),
                  child: Text('Forget password?'),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: signIn,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red
                ),
                  child: Text("Sign In",style: TextStyle(color: Colors.white),),
              ),
            ),
            SizedBox(height: 30),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: Colors.teal,
                textStyle: TextStyle(fontSize: 16.0),
              ),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(color: Colors.teal, fontSize: 16.0),
                    ),
                    TextSpan(
                      text: "Sign Up now",
                      style: TextStyle(color: Colors.red, fontSize: 16.0, fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.to(const SignupPage()),
                    ),
                  ],
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
