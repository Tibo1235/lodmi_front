import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/user.dart';
import '/utility/providerUser.dart';
import '/flutter_svg.dart';
import 'dart:convert';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  @override
  Widget build(BuildContext context) {
    // final user = userProvider.user;

    const String assetName = 'assets/images/logo_svg.svg';

    return Container(
      padding: const EdgeInsets.all(20),
      color: const Color(0xFFF8E9DE),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const SizedBox(height: 8.0),
          Container(
            width: 50,
            padding: const EdgeInsets.symmetric(
                horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: const Color(0xA68A9B6E),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: const Text(
              "Pseudo : utilisateur", // <-- Ajoutez un texte ici
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            width: 50,
            padding: const EdgeInsets.symmetric(
                horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: const Color(0xA68A9B6E),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: const Text(
              "Email : utilisateur@example.com", // <-- Ajoutez un texte ici
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            width: 50,
            padding: const EdgeInsets.symmetric(
                horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: const Color(0xA68A9B6E),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: const Text(
              "Code postal : 75000", // <-- Ajoutez un texte ici
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            width: 50,
            padding: const EdgeInsets.symmetric(
                horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: const Color(0xA68A9B6E),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: const Text(
              "Ville : Paris", // <-- Ajoutez un texte ici
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
