import 'package:canteen_app/pages/details_page.dart';
import 'package:canteen_app/pages/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/my_drawer.dart';
import 'build_menu_item_page.dart';
import 'main_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final user = FirebaseAuth.instance.currentUser;

  void navigateToMessagesPage(int id, String title, String imagePath, double price) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => DetailsPage(
        id: id,
        cardTitle: title,
        cardImagePath: imagePath,
        price: price,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Center(
              child: Text(
                "Menu",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(
                hintText: "Search your food",
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
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 20,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  final id = product['id'] as int;
                  final title = product['title'] as String?;
                  final imagePath = product['imagePath'] as String?;
                  final price = product['price'];

                  if (title == null || imagePath == null || price == null) {
                    // Handle error appropriately or skip this item
                    return SizedBox(); // Or use an error widget
                  }

                  return GestureDetector(
                    onTap: () => navigateToMessagesPage(id, title, imagePath, price),
                    child: BuildMenuItemPage(
                      id: id,
                      title: title,
                      imagePath: imagePath,
                      price: price,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
