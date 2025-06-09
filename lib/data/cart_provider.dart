import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> cartArr = [];

  void addtoCart(Map<String, dynamic> value) {
    cartArr.add(value);
    notifyListeners();
  }

  void removefromCart(Map<String, dynamic> value) {
    cartArr.remove(value);
    notifyListeners();
  }

  void resetCart() {
    cartArr.clear();
    notifyListeners();
  }
}
