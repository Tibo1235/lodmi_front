import 'dart:convert';

import 'package:http/http.dart';


class User {
  final int id;
  final String username;
  final String email;
  final String token;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.token,
  });

  // Factory constructor pour créer un User à partir d'une réponse JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      token: json['token'],
    );
  }

  // Méthode pour convertir un User en JSON (utile pour la persistance ou autres opérations)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'token': token,
    };
  }
}

class Auth {
  static get http => null;

  static Future<User?> authenticate(String username, String password) async {
    // Appel à l'API backend pour vérifier les informations de connexion
    final response = await http.post(
      Uri.parse('https://ton-backend-url/api/auth/login'), // Mets l'URL de ton API ici
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Si la réponse est valide, on extrait l'utilisateur
      final jsonResponse = jsonDecode(response.body);
      return User.fromJson(jsonResponse['user']); // Adapte selon le format JSON de ton backend
    } else {
      // Si la connexion échoue, on retourne null
      return null;
    }
  }
}
