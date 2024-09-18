import 'package:flutter/material.dart';
import 'package:lodmi_front/providers/user_provider.dart'; // Utilisez le bon chemin
import 'models/user_model.dart';
import 'pages/accueil.dart'; // Assurez-vous que le chemin est correct
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Votre App',
      home: LoginPage(),  // Assurez-vous que HomePage est bien défini ici
    );
  }
}
