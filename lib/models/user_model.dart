import 'package:flutter/material.dart';

class UserModel with ChangeNotifier {
  String? _username;
  bool _isAdmin = false;
  bool _isBotaniste = false;

  String? get username => _username;
  bool get isAdmin => _isAdmin;
  bool get isBotaniste => _isBotaniste;

  void setUser(String username, {bool isAdmin = false, bool isBotaniste = false}) {
    _username = username;
    _isAdmin = isAdmin;
    _isBotaniste = isBotaniste;
    notifyListeners();
  }

  void clearUser() {
    _username = null;
    _isAdmin = false;
    _isBotaniste = false;
    notifyListeners();
  }
}
