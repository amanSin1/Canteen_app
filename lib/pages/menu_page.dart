
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                buildMenuItem('Biryani', 'assets/images/biryani.png'),
                buildMenuItem('Burger', 'assets/images/burger.png'),
                buildMenuItem('Cold Drink', 'assets/images/cold_drink.png'),
                buildMenuItem('Fries', 'assets/images/fries.png'),
                buildMenuItem('Ice-cream', 'assets/images/ice_cream.png'),
                buildMenuItem('Pizza', 'assets/images/pizza.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItem(String title, String imagePath) {
    return Card(
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
    );
  }
}
