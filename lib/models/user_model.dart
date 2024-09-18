import 'package:flutter/material.dart';
import 'package:lodmi_front/models/user.dart'; // Assurez-vous que ce chemin est correct

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
