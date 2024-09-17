import 'package:flutter/material.dart';
import '/pages/account_page.dart';
import 'package:provider/provider.dart';  // Utilisé pour gérer l'état utilisateur

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // Appelle setState pour mettre à jour l'index de la page courante
  void setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Accède à l'utilisateur à partir du Provider (ou autre méthode de gestion d'état)
    final user = Provider.of<UserModel>(context);  // Exemple avec Provider
    final isAdmin = user.isAdmin;
    final isBotaniste = user.isBotaniste;

    return Scaffold(
      appBar: AppBar(
        title: [
          Text("Bienvenue"),
          Text("Créer une annonce"),
          if (isAdmin || isBotaniste) Text("Liste fiches"),
          Text("Détails du compte"),
        ][_currentIndex],
      ),
      body: [
        AccountPage(),  // Widget de gestion du compte
      ][_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setCurrentIndex(index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Annonce',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            label: 'Garde',
            backgroundColor: Colors.green,
          ),
          if (isAdmin || isBotaniste)
            BottomNavigationBarItem(
              icon: Icon(Icons.create),
              label: 'Fiches',
              backgroundColor: Colors.green,
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Compte',
            backgroundColor: Colors.green,
          ),
        ],
      ),
    );
  }
}

class UserModel {
  final String username;
  final bool isAdmin;
  final bool isBotaniste;

  UserModel({
    required this.username,
    this.isAdmin = false,
    this.isBotaniste = false,
  });
}