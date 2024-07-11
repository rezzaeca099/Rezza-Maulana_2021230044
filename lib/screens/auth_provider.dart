import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  Future<void> login(String username, String password) async {
    final url = Uri.parse('http://mobilecomputing.my.id/api_rezza/login.php');
    final response = await http.post(
      url,
      body: json.encode({'username': username, 'password': password}),
    );

    final responseData = json.decode(response.body);

    if (responseData['status'] == 'success') {
      _isAuthenticated = true;
    } else {
      _isAuthenticated = false;
    }

    notifyListeners();
  }

  Future<void> register(String username, String password) async {
    final url = Uri.parse('http://mobilecomputing.my.id/api_rezza/register.php');
    final response = await http.post(
      url,
      body: json.encode({'username': username, 'password': password}),
    );

    final responseData = json.decode(response.body);

    if (responseData['status'] == 'success') {
      _isAuthenticated = true;
    } else {
      _isAuthenticated = false;
    }

    notifyListeners();
  }
}
