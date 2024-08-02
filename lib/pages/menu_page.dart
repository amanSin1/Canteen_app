import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/my_drawer.dart';
import 'main_page.dart';
class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Center(
              child: Text("Menu", style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),),
            ),
            SizedBox(height: 30,),
            TextField(
              decoration: InputDecoration(
                hintText: " Search your food",
                suffixIcon: Icon(Icons.search),
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 30,
                mainAxisSpacing: 20,
                children: [
                  buildMenuItem(context, 'Biryani', 'assets/images/biryani.png'),
                  buildMenuItem(context, 'Burger', 'assets/images/burger.png'),
                  buildMenuItem(context, 'Cold Drink', 'assets/images/cold_drink.png'),
                  buildMenuItem(context, 'Fries', 'assets/images/fries.png'),
                  buildMenuItem(context, 'Ice-cream', 'assets/images/ice_cream.png'),
                  buildMenuItem(context, 'Pizza', 'assets/images/pizza.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(BuildContext context, String title, String imagePath) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(
              initialIndex: 1,
              cardTitle: title,
              cardImagePath: imagePath,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                height: 90.0,
                width: 90.0,
              ),
              SizedBox(height: 10.0),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
