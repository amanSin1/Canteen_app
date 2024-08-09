import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../model/cart_provider.dart';
import 'address_related_page/select_address_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late String userId;
  Map<String, bool> isLoadingMap = {};

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid;
      // Fetch initial cart items and update CartProvider
      _fetchAndSetCartItems();
    } else {
      // Handle case where the user is not logged in
      Get.snackbar('Error', 'User not signed in');
    }
  }

  void _fetchAndSetCartItems() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cart')
          .get();

      List<Map<String, dynamic>> cartItems = snapshot.docs.map((doc) => {
        ...doc.data() as Map<String, dynamic>,
        'id': doc.id,
      }).toList();

      // Update CartProvider with fetched items
      Provider.of<CartProvider>(context, listen: false).addProducts(cartItems);
    } catch (e) {
      print('Failed to fetch cart items: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchAddresses(String userId) async {
    List<Map<String, dynamic>> addresses = [];
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('addresses')
          .get();

      addresses = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print('Failed to fetch addresses: $e');
    }
    return addresses;
  }

  void placeOrder(BuildContext context, List<Map<String, dynamic>> cartItems) async {
    List<Map<String, dynamic>> addresses = await fetchAddresses(userId);

    if (addresses.isEmpty) {
      Get.snackbar('No Addresses Found', 'Please add a delivery address.'); }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectAddressPage(cartItems: cartItems, addresses: addresses),
        ),
      );



  }

  void _removeFromCart(String itemId, Map<String, dynamic> product) async {
    setState(() {
      isLoadingMap[itemId] = true; // Start loading for the specific item
    });


    try {
      // Remove the item from Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(itemId as String?)
          .delete();

      // Remove from local provider
      Provider.of<CartProvider>(context, listen: false).removeProduct(product);

      Get.snackbar('Removed', 'Product removed from cart');
    } catch (e) {
      print('Failed to remove item from cart: $e');
      Get.snackbar('Error', 'Failed to remove item from cart');
    }

    setState(() {
      isLoadingMap[itemId] = false; // Start loading for the specific item
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        final cartItems = cartProvider.cartItems;
        double totalPrice = 0;
        for (var item in cartItems) {
          totalPrice += item['totalPrice'] as double;
        }

        final theme = Theme.of(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Orders",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: cartItems.isEmpty
                    ? Center(child: Text('Your cart is empty.'))
                    : ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final product = cartItems[index];
                    final itemId = product['id'].toString();
                    final isLoading = isLoadingMap[itemId] ?? false;

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(product['imagePath']),
                      ),
                      title: Text(
                        product['title'] as String,
                        style: TextStyle(color: theme.colorScheme.onSurface),
                      ),
                      subtitle: Text(
                        'Quantity: ${product['quantity']} | Total: \$${product['totalPrice'].toStringAsFixed(2)}',
                        style: TextStyle(color: theme.colorScheme.onSurface),
                      ),
                      trailing: isLoading
                          ? CircularProgressIndicator() // Show only for the specific item
                          : IconButton(
                        onPressed: () {
                          _removeFromCart(itemId, product);
                        },
                        icon: Icon(Icons.delete, color: Colors.red),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  border: Border(
                    top: BorderSide(color: theme.colorScheme.onSurface, width: 1.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (cartItems.isEmpty) {
                          Get.snackbar('Empty Cart', 'Add items to the cart before placing an order');
                        } else {
                          placeOrder(context, cartItems);
                        }
                      },
                      child: Text('Place Order', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                        minimumSize: Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
