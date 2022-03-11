import "package:flutter/material.dart";

class CartItem {
  final String title;
  final String id;
  final double price;
  final int quantity;

  CartItem(
      {required this.title,
      required this.id,
      required this.price,
      required this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem>? _items = {};
  Map<String, CartItem> get items {
    return {...items};
  }

  int get itemCount {
    return _items!.length;
  }

  void add(String productId, String title, double price) {
    if (_items!.containsKey(productId)) {
      _items!.update(
          productId,
          (value) => CartItem(
              title: value.title,
              id: value.id,
              price: value.price,
              quantity: value.quantity + 1));
    } else {
      _items!.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }

  double totalCost() {
    double sum = 0.0;
    _items!.forEach((key, value) {
      sum += value.price * value.quantity;
    });
    return sum;
  }
}
