import 'package:canteen_app/pages/address_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../model/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
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
       // backgroundColor: theme.colorScheme.primary,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final product = cartItems[index];

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
                  trailing: IconButton(
                    onPressed: () {
                      cartProvider.removeProduct(product);
                      Get.snackbar('Removed', 'Product removed from cart');
                    },
                    icon: Icon(Icons.delete, color: theme.colorScheme.error),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  AddressPage())
                    );

                  },
                  child: Text('Place Order',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    foregroundColor:Colors.red,
                    backgroundColor: Colors.yellow,
                    padding: EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
