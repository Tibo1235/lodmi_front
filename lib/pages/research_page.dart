import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lodmi_front/utility/providerUser.dart';
import 'package:http/http.dart' as http;
import '../models/annonce.dart';
import 'detail_annonce.dart'; // Assurez-vous que ce chemin est correct

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Annonce> searchResults = [];
  String searchTerm = "";

  Future<List<Annonce>> fetchAnnoncesFromApi(UserProvider userProvider) async {
    final user = userProvider.user;
    final response = await http.get(
      Uri.parse('http://10.0.2.2:3000/annonce'),
      headers: {
        'Authorization': 'Bearer ${user?.token}',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)["resultats"];
      return data.map((json) => Annonce.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load annonces');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context); // Vérifiez l'accès au provider ici

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Effectuer une recherche',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          searchTerm = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Entrez votre terme de recherche',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          final apiArticles = await fetchAnnoncesFromApi(userProvider);
                          setState(() {
                            searchResults = apiArticles;
                          });
                        } catch (e) {
                          print('Error fetching articles: $e');
                        }
                      },
                      child: const Text('Rechercher'),
                    ),
                    if (searchResults.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          const Text(
                            'Résultats de la recherche :',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: searchResults.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewAnnonce(annonce: searchResults[index]),
                                    ),
                                  );
                                },
                                child: Card(
                                  child: ListTile(
                                    title: Text(searchResults[index].titre),
                                    subtitle: Text("annonce"),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ] else ...[
                      const SizedBox.shrink(),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
