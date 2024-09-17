import 'package:lodmi_front/models/user.dart';

import 'user_model.dart';

class Auth {
  static Future<User?> authenticate(String username, String password) async {
    // Implement your authentication logic here
    // For demonstration purposes, let's assume success:
    return User(
      username: username,
      isAdmin: true,       // Replace with actual logic
      isBotaniste: false,  // Replace with actual logic
    );
  }
}
