import 'package:flutter/material.dart';
import './cart_item.dart';

class OrderItem {
  final String id;
  final DateTime date;
  final List<CartItem> products;
  final double amount;

  OrderItem(
      {required this.id,
      required this.date,
      required this.products,
      required this.amount});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  void add(List<CartItem> olist, double oamount) {
    _orders.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            date: DateTime.now(),
            products: olist,
            amount: oamount));

    notifyListeners();
  }
}
