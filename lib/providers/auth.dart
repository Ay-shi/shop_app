import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiry;
  String? _userId;

  Future<void> signUp(String emailId, String password) async {
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAIUQwiCjDtQ4PRH9zLL3tlYBczQbvarj8");
    final response = await http.post(url,
        body: jsonEncode({
          "email": emailId,
          "password": password,
          "returnSecureToken": true,
        }));
    print(jsonDecode(response.body));
  }
}
