import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/HttpException.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavourite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.price,
      this.isFavourite = false});

  Future<void> toggleFvourite() async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    final url = Uri.https(
        "shop-app-91dcd-default-rtdb.asia-southeast1.firebasedatabase.app",
        "/proucts/${id}");
    try {
      final response =
          await http.patch(url, body: jsonEncode({"isFavourite": isFavourite}));
      notifyListeners();
      if (response.statusCode >= 400) {
        isFavourite = oldStatus;
        notifyListeners();
        // throw HttpException(message)
      }
    } catch (error) {
      print("eror");
      isFavourite = oldStatus;
      notifyListeners();
      throw HttpException("error occured hile changing favourite status");
    }
  }
}
