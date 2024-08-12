import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addProduct(Map<String, dynamic> product) {
    bool itemExists = _cartItems.any((item) => item['id'] == product['id']);
    if (!itemExists) {
      _cartItems.add(product);
      notifyListeners();
    }
  }

  void removeProduct(Map<String, dynamic> product) {
    _cartItems.removeWhere((item) => item['id'] == product['id']);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}

