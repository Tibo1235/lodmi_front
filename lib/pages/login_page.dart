import 'dart:convert';  // Pour jsonEncode et jsonDecode
import 'package:http/http.dart' as http;  // Pour les requêtes HTTP
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lodmi_front/models/user_model.dart'; // Ajustez le chemin d'importation si nécessaire
import 'package:lodmi_front/pages/creation_account.dart'; // Ajustez le chemin d'importation si nécessaire
import 'package:lodmi_front/pages/accueil.dart';

import '../providers/user_provider.dart'; // Assurez-vous que le chemin est correct

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isButtonVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    _usernameController.addListener(updateButtonVisibility);
    _passwordController.addListener(updateButtonVisibility);
  }

  void updateButtonVisibility(){
    setState(() {
      isButtonVisible = _usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF8E9DE),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _page(context),
      ),
    );
  }

  Widget _page(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              _icon(),
              const SizedBox(height:50),
              _inputField("Email", _usernameController),
              const SizedBox(height:20),
              _inputField("Mot de passe", _passwordController, isPassword: true),
              const SizedBox(height:50),
              _loginBtn(context),
              const SizedBox(height:10),
              Divider(
                color: Color(0xFF354733),
                thickness: 5,
                indent: 40,
                endIndent: 40,
              ),
              const SizedBox(height: 5),
              _signUpBtn(context),
              const SizedBox(height:20),
              _extraText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _icon() {
    return Container(
      child: Image.asset(
        'assets/images/logoavecfond.png',
        width: 250,
        height: 250,
      ),
    );
  }

  Widget _inputField(String hintText, TextEditingController controller, {bool isPassword = false}){
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: Color(0xFF8A9B6E)),
    );
    return TextField(
      style: const TextStyle(color: Color(0xFF354733)),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFF354733)),
        enabledBorder: border,
        focusedBorder: border,
        filled: true,
        fillColor: Color(0xA08A9B6E),
      ),
      obscureText: isPassword,
    );
  }

  Widget _loginBtn(BuildContext context) {
    return isButtonVisible ? TextButton(
      onPressed: () async {
        final email = _usernameController.text;
        final password = _passwordController.text;

        if (email.isEmpty || password.isEmpty) {
          _showErrorDialog(context, "Veuillez entrer vos identifiants.");
          return;
        }

        try {
          final response = await http.post(
            Uri.parse('http://10.0.2.2:3000/users/login'), // Ajustez l'URL
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'email': email,
              'password': password,
            }),
          );

          if (response.statusCode == 200 || response.statusCode == 201) {
            // Connexion réussie
            final data = jsonDecode(response.body);
            final userModel = Provider.of<UserModel>(context, listen: false);
            userModel.updateUsername(email); // Mettez à jour userModel avec les données du serveur
            userModel.updateStatus(data['isAdmin'], data['isBotaniste']); // Mettez à jour le statut en fonction de la réponse
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else {
            _showErrorDialog(context, "Échec de la connexion, veuillez réessayer.");
          }
        } catch (e) {
          _showErrorDialog(context, "Erreur de connexion, veuillez réessayer.");
        }
      },
      child: Text(
        "Se connecter",
        style: TextStyle(fontSize: 20, color: Color(0xFF354733)),
      ),
    ) : SizedBox();
  }

  Widget _signUpBtn(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserRegistrationPage()),
        );
      },
      child: Text(
        "S'inscrire",
        style: TextStyle(fontSize: 20, color: Color(0xFF354733)),
      ),
    );
  }

  Widget _extraText(){
    return const Text(
      "Vous n'arrivez pas à accéder à votre compte?",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: Color(0xFF354733),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erreur'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
