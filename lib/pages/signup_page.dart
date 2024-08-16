import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../my_textfield.dart';
import '../wrapper.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> signup() async {
    try {
      // Check if email, password, and username are not empty
      if (email.text.isEmpty || password.text.isEmpty || username.text.isEmpty) {
        Get.snackbar("Error", "Please fill in all fields.", snackPosition: SnackPosition.BOTTOM);
        return;
      }

      // Create the user with email and password
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      // Update the displayName for the user
      await userCredential.user?.updateDisplayName(username.text);

      // Reload the user to reflect the displayName update
      await userCredential.user?.reload();

      // Log UID for debugging
      print("User UID: ${userCredential.user!.uid}");

      // Save the user data in Firestore
      await _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email.text,
        'username': username.text,
      });

      // Log Firestore success
      print("Firestore document created successfully.");

      // Navigate to the Wrapper screen
      Get.offAll(const Wrapper());

    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'email-already-in-use':
          message = "The email address is already in use.";
          break;
        case 'invalid-email':
          message = "The email address is not valid.";
          break;
        case 'operation-not-allowed':
          message = "Operation not allowed. Please contact support.";
          break;
        case 'weak-password':
          message = "The password is too weak.";
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              MyTextfield(hintText: "Enter your email", controller: email,obscureText: false,),
              SizedBox(height: 10),
              MyTextfield(hintText: "Enter your Username", controller: username,obscureText: false,),
              SizedBox(height: 10),
              MyTextfield(hintText: "Enter your password", controller: password,obscureText: false,),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: signup,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green
                  ),
                  child: const Text("Sign up", style: TextStyle(color: Colors.black)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
