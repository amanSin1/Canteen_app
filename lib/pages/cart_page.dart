// cart_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../model/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: cartProvider.cartItems.length,
        itemBuilder: (context, index) {
          final product = cartProvider.cartItems[index];

          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(product['imagePath']),
            ),
            title: Text(
              product['title'] as String,
            ),
            subtitle: Text(
              'Quantity: ${product['quantity']} | Total: \$${product['totalPrice'].toStringAsFixed(2)}',
            ),
            trailing: IconButton(
              onPressed: () {
                cartProvider.removeProduct(product);
                Get.snackbar('Removed', 'Product removed from cart');
              },
              icon: Icon(Icons.delete, color: Colors.red),
            ),
          );
        },
      ),
    );
  }
}
