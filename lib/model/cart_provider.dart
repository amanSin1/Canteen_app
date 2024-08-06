// model/cart_provider.dart
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addProduct(Map<String, dynamic> product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeProduct(Map<String, dynamic> product) {
    _cartItems.remove(product);
    notifyListeners();
  }
}
