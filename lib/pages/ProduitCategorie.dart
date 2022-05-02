import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

class ProduitCategorie extends StatefulWidget {
  final articlePanier;
  final produitSelectionner;
  final produitList;
  final nomCateg;

  const ProduitCategorie({
    Key? key,
    this.articlePanier,
    this.produitSelectionner,
    this.produitList,
    this.nomCateg,
  }) : super(key: key);

  @override
  State<ProduitCategorie> createState() => _ProduitCategoriePageState();
}

class _ProduitCategoriePageState extends State<ProduitCategorie> {
  late bool testShowWidget = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.nomCateg.toString().toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
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
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.produitList.length,
              itemBuilder: (BuildContext context, int index) {
                print(widget.produitList[index].prix.toString());
                if (widget.produitList[index].categorie ==
                    widget.nomCateg.toString().toLowerCase()) {
                  testShowWidget = true;
                } else {
                  testShowWidget = false;
                }
                return testShowWidget
                    ? Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          elevation: 2.0,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    '${widget.produitList[index].imageProduit}',
                                    height: 140,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.produitList[index].nomProduit
                                            .toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        '${widget.produitList[index].prix}' +
                                            '€',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    '${widget.produitList[index].description}',
                                    maxLines: 5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
