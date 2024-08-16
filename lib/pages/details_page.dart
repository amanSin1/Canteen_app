import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../model/cart_provider.dart';
import 'cart_page.dart'; // Import your CartPage

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
  bool isLoading = false;
  bool isAddedToCart = false; // New state variable

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
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      final userId = user?.uid;

      if (userId != null) {
        final userCartCollection = FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('cart');

        // Check for existing item in Firestore
        final existingCartItem = await userCartCollection
            .where('id', isEqualTo: widget.id)
            .limit(1)
            .get();

        if (existingCartItem.docs.isEmpty) {
          // Add the item to Firestore if it's not already present
          await userCartCollection.add({
            'id': widget.id,
            'title': widget.cardTitle,
            'imagePath': widget.cardImagePath,
            'price': widget.price,
            'quantity': quantity,
            'totalPrice': totalPrice,
          });
          Get.snackbar('Success', 'Product added to cart');

          // Add to local cart state
          Provider.of<CartProvider>(context, listen: false).addProduct({
            'id': widget.id,
            'title': widget.cardTitle,
            'imagePath': widget.cardImagePath,
            'price': widget.price,
            'quantity': quantity,
            'totalPrice': totalPrice,
          });
        } else {
          Get.snackbar('Info', 'Item is already in the cart');
        }

        setState(() {
          isAddedToCart = true;
        });
      }
    } catch (error) {
      Get.snackbar('Error', 'Failed to add product to cart. Please try again.');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    // Reset state when navigating away
    isLoading = false;
    isAddedToCart = false;
    super.dispose();
  }




  void _goToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CartPage()),
    ).then((_) {
      // Reset state to allow adding more items after returning
      setState(() {
        // isAddedToCart = false;
      });
    });
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
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.asset(
                            widget.cardImagePath,
                           // fit: BoxFit.cover,
                           // width: double.infinity,
                            height: 220,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    SizedBox(height: 10,),
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
                    onPressed: isLoading
                        ? null
                        : isAddedToCart
                        ? _goToCart
                        : _addToCart,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                    ),
                    child: isLoading
                        ? CircularProgressIndicator(
                      valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                        : Text(isAddedToCart ? 'Go to Cart' : 'Add to my Order'),
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
