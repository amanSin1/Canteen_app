// detailspage.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../model/cart_provider.dart';

class DetailsPage extends StatefulWidget {
  final int id;
  final String cardTitle;
  final String cardImagePath;
  final double price;

  DetailsPage({
    super.key,
    required this.id,
    required this.cardTitle,
    required this.cardImagePath,
    required this.price,
  });

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int quantity = 1;
  late double totalPrice;

  @override
  void initState() {
    super.initState();
    totalPrice = widget.price;
  }

  void _incrementQuantity() {
    setState(() {
      quantity++;
      totalPrice = widget.price * quantity;
    });
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        totalPrice = widget.price * quantity;
      });
    }
  }
  void _addToCart() async {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;

    if (userId != null) {
      // Update the local cart state first
      Provider.of<CartProvider>(context, listen: false).addProducts([
        {
          'id': widget.id,
          'title': widget.cardTitle,
          'imagePath': widget.cardImagePath,
          'price': widget.price,
          'quantity': quantity,
          'totalPrice': totalPrice,
        }
      ]);

      // Then save the item in Firestore under the user's cart
      final userCartCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cart');

      await userCartCollection.add({
        'id' : widget.id,
        'title': widget.cardTitle,
        'imagePath': widget.cardImagePath,
        'price': widget.price,
        'quantity': quantity,
        'totalPrice': totalPrice,
      });

      // Provide feedback to the user
      Get.snackbar('Success', 'Product added to cart');
    } else {
      // If no user is signed in, show an error
      Get.snackbar('Error', 'You need to be signed in to add items to the cart');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.red,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(
                            widget.cardImagePath,
                            height: 70,
                          ),
                        ),
                        Spacer(),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.cardTitle,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Card(
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: _decrementQuantity,
                              ),
                              Text(
                                '$quantity',
                                style: TextStyle(fontSize: 16),
                              ),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: _incrementQuantity,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '\$${totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: _addToCart,
                    child: Text('Add to my Order'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
