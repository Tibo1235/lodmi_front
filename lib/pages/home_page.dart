import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/user_model.dart'; // Assure-toi que le bon modèle est importé
import '/pages/account_page.dart';
import 'accueil.dart';  // Assure-toi que les bons widgets sont importés

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);  // Accède à UserModel
    final isAdmin = user.isAdmin;
    final isBotaniste = user.isBotaniste;

    // Crée les titres pour l'AppBar
    final List<Widget> appBarTitles = [
      Text("Bienvenue"),
      Text("Créer une annonce"),
      if (isAdmin || isBotaniste) Text("Liste fiches"),
      Text("Détails du compte"),
    ];

    // Crée les pages pour le body
    final List<Widget> pages = [
      AccountPage(),  // Ajoute toutes les pages ici
      // Ajouter d'autres pages ici si nécessaire
    ];

    return Scaffold(
      appBar: AppBar(
        title: appBarTitles.isNotEmpty && _currentIndex < appBarTitles.length
            ? appBarTitles[_currentIndex]
            : Text("Default Title"),  // Fournir un titre par défaut
      ),
      body: pages.isNotEmpty && _currentIndex < pages.length
          ? pages[_currentIndex]
          : Center(child: Text("Page not found")),  // Fournir un widget par défaut
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
