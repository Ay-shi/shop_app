import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:shop_app/models/HttpException.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiry;
  String? _userId;

  Timer? _authtimer;

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

  Future<bool> tryAutoLogin() async {
    final _prefs = await SharedPreferences.getInstance();
    if (!_prefs.containsKey('userData')) {
      return false;
    }
    final extractedData =
        jsonDecode(_prefs.getString('userData')!) as Map<String, dynamic>;
    _expiry = DateTime.parse(extractedData['expiry']!);
    if (!_expiry!.isAfter(DateTime.now())) return false;
    _token = extractedData["token"];
    _userId = extractedData['userId'];
    _automaticLogOut();
    notifyListeners();
    return true;
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
      _automaticLogOut();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final _userData = jsonEncode({
        "token": _token,
        "userId": _userId,
        "expiry": _expiry!.toIso8601String()
      });
      prefs.setString("userData", _userData);
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

  Future<void> logOut() async {
    _token = null;
    _expiry = null;
    _userId = null;
    if (_authtimer != null) {
      _authtimer!.cancel();
      _authtimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("userData");
  }

  void _automaticLogOut() {
    if (_authtimer != null) _authtimer!.cancel();
    final _timetoExpiry = _expiry!.difference(DateTime.now()).inSeconds;
    Timer(Duration(seconds: _timetoExpiry), logOut);
  }
}
