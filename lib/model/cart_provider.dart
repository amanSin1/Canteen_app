import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addProducts(List<Map<String, dynamic>> products) {
    _cartItems.addAll(products);
    notifyListeners();
  }

  void removeProduct(Map<String, dynamic> product) {
    _cartItems.remove(product);
    notifyListeners();
  }
}
