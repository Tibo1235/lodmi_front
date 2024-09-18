import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateFichePage extends StatefulWidget {
  @override
  _CreateFichePageState createState() => _CreateFichePageState();
}

class _CreateFichePageState extends State<CreateFichePage> {
  List<File> images = [];
  TextEditingController especesController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController conseilController = TextEditingController();

  Future<void> getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

    final imageTemporary = File(image.path);

    setState(() {
      if (images.length < 1) {
        images.add(imageTemporary);
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Limite d'images atteinte"),
              content: Text("Une image à la fois"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE1BD98), // Couleur de fond
                  ),
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  void removeImage(int index) {
    setState(() {
      images.removeAt(index);
    });
  }

  Widget buildGridView() {
    return images.isEmpty
        ? SizedBox.shrink()
        : GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(images.length, (index) {
        File image = images[index];
        Uint8List imageBytes = image.readAsBytesSync();
        return Stack(
          children: [
            Container(
              margin: EdgeInsets.all(8.0),
              child: Image.memory(
                Uint8List.fromList(imageBytes),
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () => removeImage(index),
              ),
            ),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8E9DE),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            margin: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xB2E1BD98),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Titre du post: ${especesController.text}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => getImage(ImageSource.gallery),
                  child: Text('Sélectionner avec la gallerie'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF8A9B6E),
                  ),
                ),
                SizedBox(height: 20),
                buildGridView(),
                SizedBox(height: 20),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: conseilController,
                  decoration: InputDecoration(labelText: 'Conseil'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Action placeholder
                    print('Créer');
                  },
                  child: Text('Créer'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF8A9B6E),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CreateFichePage(),
  ));
}
