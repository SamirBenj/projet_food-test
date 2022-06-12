import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projet_food/pages/RecettePage.dart';
import 'package:projet_food/sqflite/Database/DatabaseHandler.dart';
import 'package:projet_food/sqflite/models/RecipeModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../class/Utility.dart';

class AjoutRecette extends StatefulWidget {
  AjoutRecette({Key? key}) : super(key: key);

  @override
  State<AjoutRecette> createState() => _AjoutRecetteState();
}

class _AjoutRecetteState extends State<AjoutRecette> {
  //int qte;

  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  String? email;
  String? username;
  // String? id;
  var dbHelper;
  TextEditingController nomPlat = TextEditingController();
  TextEditingController description = TextEditingController();
  // final ImagePicker _picker = ImagePicker();
  final ImagePicker _picker = ImagePicker();
  File? imagePic;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Initialisation de la Base de données
    dbHelper = DbHandler();
  }

  final _recetteKey = GlobalKey<FormState>();

  void ajouteReccette() async {
    if (_recetteKey.currentState!.validate()) {
      String plat = nomPlat.text;
      String descr = description.text;
      Recipe myrecipe =
          Recipe(null, plat, imagePic!.path.toString(), username, descr);
      await DbHandler().saveRecipe(myrecipe).then((userRecipe) {
        print('it worked');
        print(userRecipe);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => RecettePage()),
          (Route<dynamic> route) => false,
        );
      }).catchError((onError) {
        print(onError);
        print(context.toString() + "Error: Data Save Fail");

        final snack = SnackBar(
          content: const Text('Un problme est survenue ❌'),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snack);
      });
    } else {
      print("fill the fields");
    }
  }

  Future<void> getImagePic() async {
    // var pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    // // final filename = image = new File(pickedImage!.path);
    // // String bit = base64Encode(pickedImage!.readAsBytes());
    // setState(() {});
    final XFile? myImage = await _picker.pickImage(source: ImageSource.gallery);

    final File? imageTemp = File(myImage!.path);
    setState(() {
      this.imagePic = imageTemp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.image),
        onPressed: () async {
          getImagePic();
        },
        label: Text('Ajouter une image'),
      ),
      appBar: AppBar(
        title: Text('Création Recette'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(111, 186, 255, 100),
      ),
      body: Form(
        key: _recetteKey,
        child: Column(
          children: [
            // Image.file(image ?? null),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: Row(
                children: [
                  Text(
                    'Partager nous vos recettes 👋',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            imagePic != null
                ? Image.file(
                    imagePic!,
                    width: 100,
                    height: 100,
                  )
                : Text(
                    'Veuillez choisir une image',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: nomPlat,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Le nom du plat !';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Entrer le nom du plat',
                    ),
                    obscureText: false,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  // Image.memory(im ASzage);
                  TextFormField(
                    controller: description,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'La description du plat !';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Entrer le descriptif',
                    ),
                    obscureText: false,
                    maxLines: 5,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                onPressed: () {
                  ajouteReccette();
                },
                child: Text('Partager'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
