import 'package:flutter/foundation.dart';  // Assurez-vous que ChangeNotifier est importé

class UserModel extends ChangeNotifier {
  String username;
  bool isAdmin;
  bool isBotaniste;

  UserModel({
    required this.username,
    this.isAdmin = false,
    this.isBotaniste = false,
  });

  void updateUsername(String newUsername) {
    username = newUsername;
    notifyListeners();
  }

  void updateStatus(bool adminStatus, bool botanisteStatus) {
    isAdmin = adminStatus;
    isBotaniste = botanisteStatus;
    notifyListeners();
  }
}
