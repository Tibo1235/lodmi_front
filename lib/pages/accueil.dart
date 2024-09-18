import 'package:flutter/material.dart';
import 'package:lodmi_front/pages/research_page.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import 'account_page.dart';
import 'fiche_creation.dart';
import '../providers/user_provider.dart'; // Assurez-vous que le chemin est correct
import './research_page.dart';
import './account_page.dart';
import './fiche_creation.dart'; // Assurez-vous que le chemin est correct

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
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    //final isAdmin = user?.isAdmin ?? false;
    //final isBotaniste = user?.isBotaniste ?? false;

    return Scaffold(
      body: [
        SearchPage(),
        AccountPage(),
        CreateFichePage(),
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
          /*if (isAdmin || isBotaniste)
            BottomNavigationBarItem(
              icon: Icon(Icons.create),
              label: 'Fiches',
              backgroundColor: Colors.green,
            ),*/
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
