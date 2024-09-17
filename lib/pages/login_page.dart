import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../models/user_provider.dart';
import '/models/user_model.dart'; // Adjust the import path if necessary
import '/utility/auth.dart'; // Adjust the import path if necessary
import '/pages/home_page.dart'; // Adjust the import path if necessary
import '/providers/user_provider.dart';
import 'accueil.dart'; // Adjust the import path if necessary

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isButtonVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(updateButtonVisibility);
    _passwordController.addListener(updateButtonVisibility);
  }

  void updateButtonVisibility() {
    setState(() {
      isButtonVisible = _usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty;
    });
  }

  Future<void> login(BuildContext context) async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    final user = await Auth.authenticate(username, password);

    if (user != null) {
      // Use UserProvider to manage user state
      Provider.of<UserProvider>(context, listen: false).setUser(
        UserModel(
          username: user.username,
          isAdmin: user.isAdmin,
          isBotaniste: user.isBotaniste,
        ),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Identifiants incorrects. Veuillez réessayer.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.brown,
            Colors.green,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _page(context),
      ),
    );
  }

  Widget _page(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _icon(),
              const SizedBox(height: 50),
              _inputField("Email", _usernameController),
              const SizedBox(height: 20),
              _inputField("Mot de passe", _passwordController, isPassword: true),
              const SizedBox(height: 50),
              _loginBtn(context),
              const SizedBox(height: 50),
              _extraText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _icon() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        shape: BoxShape.circle,
      ),
      child: Image.asset(
        'assets/images/logo.png',
        width: 120,
        height: 120,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _inputField(String hintText, TextEditingController controller, {bool isPassword = false}) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: Colors.white),
    );
    return TextField(
      style: const TextStyle(color: Colors.white),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: border,
        focusedBorder: border,
      ),
      obscureText: isPassword,
    );
  }

  Widget _loginBtn(BuildContext context) {
    return isButtonVisible
        ? ElevatedButton(
      onPressed: () async {
        await login(context);
      },
      child: SizedBox(
        width: double.infinity,
        child: Text(
          "Se connecter",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    )
        : SizedBox();
  }

  Widget _extraText() {
    return const Text(
      "Vous n'arrivez pas à accéder à votre compte?",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
    );
  }
}
