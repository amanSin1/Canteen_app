import 'package:canteen_app/pages/product.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      body: ListView.builder(
        itemCount: products.length,
          itemBuilder:(context,index){

          }
      ),
    );
  }
}
