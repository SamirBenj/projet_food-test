import 'package:flutter/material.dart';
import 'package:projet_food/Classes/classProduit.dart';
import 'package:badges/badges.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({
    Key? key,
    this.nomProduit,
    this.imageProduit,
    this.prix,
    this.description,
    this.valeurBool,
    this.articlePanier,
  }) : super(key: key);

  final nomProduit;
  final imageProduit;
  final prix;
  final description;
  final valeurBool;
  final articlePanier;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int totalPanier = 0;
  //List<Produit> produit;
  bool checkbox = false;

  fonctionAddition() {
    totalPanier++;
  }

  fonctionSoustraction(bool sel) {
    totalPanier--;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Description',
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
      body: Column(
        children: [
          Center(
            child: Image.asset(widget.imageProduit.toString()),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.nomProduit,
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  widget.prix.toString() + '€',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                widget.description,
                style: TextStyle(
                  color: Colors.orangeAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
