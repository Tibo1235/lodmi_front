import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserRegistrationPage extends StatefulWidget {
  @override
  _UserRegistrationPageState createState() => _UserRegistrationPageState();
}

class _UserRegistrationPageState extends State<UserRegistrationPage> {
  TextEditingController pseudoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Pour valider le formulaire
  bool _isLoading = false; // Pour indiquer l'état de chargement

  // Fonction pour soumettre les données utilisateur à l'API
  Future<void> submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Démarre le chargement
      });

      String pseudo = pseudoController.text;
      String email = emailController.text;
      String password = passwordController.text;
      String postalCode = postalCodeController.text;
      String city = cityController.text;

      // Appel à ton API backend pour enregistrer l'utilisateur
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/users/'), // Change l'URL avec ton backend
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'pseudo': pseudo,
          'email': email,
          'password': password,
          'postalCode': postalCode,
          'city': city,
        }),
      );

      setState(() {
        _isLoading = false; // Arrête le chargement
      });

      if (response.statusCode == 201) {
        // Si l'inscription réussit, afficher un message de succès
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Inscription réussie !')),
        );
      } else {
        // Si l'inscription échoue, afficher un message d'erreur
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Échec de l\'inscription, veuillez réessayer.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey, // Formulaire avec une clé globale
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: pseudoController,
                decoration: InputDecoration(labelText: 'Pseudo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un pseudo';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un email';
                  }
                  // Validation simple du format email
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Veuillez entrer un email valide';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un mot de passe';
                  }
                  if (value.length < 6) {
                    return 'Le mot de passe doit comporter au moins 6 caractères';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: postalCodeController,
                decoration: InputDecoration(labelText: 'Postal Code'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un code postal';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: cityController,
                decoration: InputDecoration(labelText: 'City'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une ville';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                onPressed: submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: UserRegistrationPage(),
  ));
}
