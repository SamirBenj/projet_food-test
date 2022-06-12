import 'dart:io';

import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:projet_food/pages/AjoutRecette.dart';
import 'package:projet_food/sqflite/Database/DatabaseHandler.dart';
import 'package:projet_food/sqflite/models/RecipeModel.dart';

class RecettePage extends StatefulWidget {
  final articlePanier;
  final produitSelectionner;
  const RecettePage({Key? key, this.articlePanier, this.produitSelectionner})
      : super(key: key);

  @override
  State<RecettePage> createState() => _RecettePageState();
}

class _RecettePageState extends State<RecettePage> {
  var dbHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DbHandler();
    DbHandler().initDb();
    DbHandler().getRecipeData().then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recette',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(111, 186, 255, 100),
        actions: [
          Badge(
            position: BadgePosition.topEnd(top: 5, end: 0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.shopping_basket,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
            badgeContent: Text(widget.articlePanier.toString()),
            badgeColor: Colors.white,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AjoutRecette()));
        },
      ),
      body: Center(
        child: Column(children: [
          Expanded(
            child: FutureBuilder<List<Recipe>>(
              future: DbHandler().getRecip(),
              // initialData: InitialData,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  // print(snapshot.data[0].titre.toString());
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      print('hello');
                      print(snapshot.data[index]?.img.toString());
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            title: Text(
                              snapshot.data[index].titre.toString(),
                            ),
                            subtitle: Text(
                              snapshot.data[index].description.toString(),
                            ),
                            trailing:
                                snapshot.data[index]?.img.toString() != null
                                    ? Image.file(
                                        File(snapshot.data[index].img),
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
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return CircularProgressIndicator();
                }
                return Text('nothing');
              },
            ),
          ),
        ]),
      ),
    );
  }
}
