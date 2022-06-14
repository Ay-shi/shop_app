import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shop_app/models/HttpException.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiry;
  String? _userId;
  Future<void> authenticate(
      String emailId, String password, String urlPart) async {
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:${urlPart}?key=AIzaSyAIUQwiCjDtQ4PRH9zLL3tlYBczQbvarj8");
    try {
      final response = await http.post(url,
          body: jsonEncode({
            "email": emailId,
            "password": password,
            "returnSecureToken": true,
          }));
      final res = jsonDecode(response.body);
      if (res["error"] != null) {
        throw HttpException(res["error"]["message"]);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUp(String emailId, String password) async {
    authenticate(emailId, password, "signUp");
  }

  Future<void> signIn(String emailId, String password) async {
    authenticate(emailId, password, "signInWithPassword");
  }
}
