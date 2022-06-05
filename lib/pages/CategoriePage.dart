import 'package:flutter/material.dart';
import 'package:projet_food/class/classCategorie.dart';
import 'package:badges/badges.dart';

import 'ProduitCategorie.dart';

class CategoriePage extends StatefulWidget {
  final articlePanier;
  final produitSelectionner;
  final produitList;

  const CategoriePage({
    Key? key,
    this.articlePanier,
    this.produitSelectionner,
    required this.produitList,
  }) : super(key: key);

  @override
  State<CategoriePage> createState() => _CategoriePageState();
}

class _CategoriePageState extends State<CategoriePage> {
  List<Categorie> categorie = [
    Categorie("burger", "assets/burger-au-fromage.png"),
    Categorie("pizza", "assets/pizza.png"),
    Categorie("Gauffre", "assets/gaufres.png"),
    Categorie("Glace", "assets/cornet-de-glace.png"),
    Categorie("Cookie", "assets/biscuits.png"),
    Categorie("Boisson", "assets/boissons-non-alcoolisees.png"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Categorie',
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
        body: Container(
          child: ListView.builder(
            itemCount: categorie.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProduitCategorie(
                              articlePanier: widget.produitSelectionner.length,
                              produitSelectionner: widget.produitSelectionner,
                              produitList: widget.produitList,
                              nomCateg: categorie[index].nom,
                            )),
                  );
                },
                child: Card(
                  elevation: 5.0,
                  color: Color.fromRGBO(111, 186, 255, 100),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  margin: EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          categorie[index].nom,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Divider(
                          thickness: 2,
                          height: 30,
                          indent: 100,
                          color: Colors.white,
                          endIndent: 100,
                        ),
                        Image(
                          width: 40,
                          height: 40,
                          image: AssetImage(
                            categorie[index].image,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
