import 'package:flutter/material.dart';
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Image.asset(
                widget.imageProduit.toString(),
                width: double.infinity,
                height: 230,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color.fromARGB(175, 111, 185, 255),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.nomProduit,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    widget.prix.toString() + '€',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.13,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 111, 185, 255),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  widget.description,
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
