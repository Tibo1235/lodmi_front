import 'package:flutter/material.dart';
import '../models/annonce.dart';

class ViewAnnonce extends StatelessWidget {
  final Annonce annonce;

  const ViewAnnonce({super.key, required this.annonce});

  Widget _buildDetailRow(String title, String value) {
    return Container(
      width: 350,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Color(0xFF8A9B6E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Color(0xFF354733),
                fontSize: 16,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              value,
              style: TextStyle(
                color: Color(0xFF354733),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Annonce'),
      ),
      backgroundColor: Color(0xFFF8E9DE),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logoentier.png',
                width: 200,
                height: 200,
              ),
              SizedBox(height: 16.0),
              Container(
                width: 400,
                decoration: BoxDecoration(
                  color: Color(0xFFE1BD98),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        annonce.titre,
                        style: TextStyle(
                          color: Color(0xFF354733),
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        annonce.pseudo ?? "Non spécifié",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      _buildDetailRow('Localisation:', annonce.proprietaireVille ?? "Non spécifié"),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildDetailRow('Date de début:', annonce.dateDebut),
                          _buildDetailRow('Date de fin:', annonce.dateFin),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      _buildDetailRow('Espèce:', annonce.espece),
                      SizedBox(height: 16.0),
                      Container(
                        width: 350,
                        decoration: BoxDecoration(
                          color: Color(0xFF8A9B6E),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Description :',
                                style: TextStyle(
                                  color: Color(0xFF354733),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                annonce.description,
                                style: TextStyle(
                                  color: Color(0xFF354733),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
