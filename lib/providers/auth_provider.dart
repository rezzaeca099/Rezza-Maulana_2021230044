import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String _username = '';

  bool get isAuthenticated => _isAuthenticated;
  String get username => _username;

  void login(String username, String password) {
    if (username == 'user' && password == 'password') {
      _isAuthenticated = true;
      _username = username;
      notifyListeners();
    }
  }

  void logout() {
    _isAuthenticated = false;
    _username = '';
    notifyListeners();
  }

  void register(String username, String password) {
    // Dummy registration, in real scenario we would save this somewhere
    if (username.isNotEmpty && password.isNotEmpty) {
      _isAuthenticated = true;
      _username = username;
      notifyListeners();
    }
  }
}
