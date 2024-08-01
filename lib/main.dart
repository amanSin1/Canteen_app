import 'dart:io';
import 'package:canteen_app/pages/login_page.dart';
import 'package:canteen_app/theme/theme_provider.dart';
import 'package:canteen_app/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ensure Firebase is initialized
  await Firebase.initializeApp(
    options: Platform.isAndroid
        ? const FirebaseOptions(
      apiKey: "AIzaSyA4SMSWNhx1tI9WQeRB7R0yhruMZ15mXZA",
      appId: "1:988800405363:android:30012b10e4b9036be93f06",
      messagingSenderId: "988800405363",
      projectId: "canteenapp-ecc48",
    )
        : DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Canteen app",
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: Wrapper(),
    );
  }
}