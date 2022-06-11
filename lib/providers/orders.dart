import 'dart:convert';

import 'package:flutter/material.dart';
import './cart_item.dart';
import 'package:http/http.dart' as http;

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

  Future<void> add(List<CartItem> olist, double oamount) async {
    DateTime timestamp = DateTime.now();
    final url = Uri.https(
        "shop-app-91dcd-default-rtdb.asia-southeast1.firebasedatabase.app",
        "/orders.json");
    try {
      final response = await http.post(url,
          body: jsonEncode({
            "date": timestamp.toIso8601String(),
            "proucts": olist
                .map((e) => {
                      "title": e.title,
                      "id": e.id,
                      "quantity": e.quantity,
                      "price": e.price
                    })
                .toList(),
            "amuount": oamount
          }));
      _orders.insert(
          0,
          OrderItem(
              id: json.decode(response.body)["name"].toString(),
              date: timestamp,
              products: olist,
              amount: oamount));

      notifyListeners();
    } catch (error) {
      print("error while adding order");
      throw error;
    }
  }
}
