import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shop_app/models/HttpException.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiry;
  String? _userId;

  bool get isAuth {
    return token != null;
  }

  String? getUserId() {
    return _userId;
  }

  String? get token {
    if (_expiry != null && _token != null && _expiry!.isAfter(DateTime.now())) {
      return _token!;
    }
    return null;
  }

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
      print(res);
      // print(res["error"]["message"]);
      if (res["error"] != null) {
        //print("throw error");
        throw HttpException(res["error"]["message"]);
      }
      _token = res["idToken"];
      _expiry =
          DateTime.now().add(Duration(seconds: int.parse(res["expiresIn"])));
      _userId = res["localId"];
      notifyListeners();
    } catch (error) {
      //print("throw error 2");
      print(error);
      throw error;
    }
  }

  Future<void> signUp(String emailId, String password) async {
    return authenticate(emailId, password, "signUp");
  }

  Future<void> signIn(String emailId, String password) async {
    return authenticate(emailId, password, "signInWithPassword");
  }
}
