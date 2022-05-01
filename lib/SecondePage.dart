//import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:projet_food/CategoriePage.dart';
import 'package:projet_food/PanierPage.dart';
import 'package:projet_food/DetailsPage.dart';
import 'package:projet_food/RecettePage.dart';
import 'package:projet_food/Classes/classProduit.dart';

class SecondePage extends StatefulWidget {
  const SecondePage({Key? key}) : super(key: key);

  @override
  State<SecondePage> createState() => _SecondePageState();
}

class _SecondePageState extends State<SecondePage> {
  int totalPanier = 0;
  bool checkbox = false;
  //int qte;

  fonctionAddition() {
    totalPanier++;
  }

  fonctionSoustraction() {
    totalPanier--;
  }

/*
  void Recup(newqte) {
    if (newqte == 1) {
      newqte == quantiter;
    } else if (newqte == 2) {
      newqte == quantiter;
    }
  }
*/
  //List listMotif = [1, 2, 3, 4, 5];

  List<Produit> produits = [
    Produit("burger", "Burger", 7, "assets/Burger.png", false,
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", 1),
    Produit("burger", "Double Cheese", 9, "assets/Double_Cheese.png", false,
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", 1),
    Produit("burger", "Triple Cheese", 11, "assets/Triple_Cheese.png", false,
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", 1),
    Produit("burger", "Chicken Burger", 13, "assets/Burger_Poulet.png", false,
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", 1),
    Produit("pizza", "Orientale", 15, "assets/Orientale.jpg", false,
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", 1),
    Produit("pizza", "Chèvre miel", 17, "assets/Chevre_miel.jpg", false,
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", 1),
    Produit("pizza", "Chorizo", 19, "assets/Chorizo.jpg", false,
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", 1),
    Produit("pizza", "4 fromage", 21, "assets/4_fromage.jpg", false,
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", 1),
  ];

//Liste pour la quantiter
  /*List<int> items = <int>[1, 2, 3, 4, 5];
  String dropdownValue = '1';
*/

  String quantiter = "1"; // variable pour la quantite rentrer

  @override
  Widget build(BuildContext context) {
    var produitSelectionner = produits.where((element) => element.valeurBool);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Accueil',
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
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PanierPage(
                                articlePanier: produitSelectionner.length,
                                produitSelectionner: produitSelectionner,
                                quantiter: quantiter,
                              )));
                },
                icon: Icon(
                  Icons.shopping_basket,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
            badgeContent: Text(totalPanier.toString()),
            badgeColor: Colors.white,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoriePage(
                                  articlePanier: produitSelectionner.length,
                                  produitSelectionner: produitSelectionner,
                                  produitList: produits,
                                )));
                  },
                  child: Text('Categories'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecettePage(
                                  articlePanier: produitSelectionner.length,
                                  produitSelectionner: produitSelectionner,
                                  //produitList: produits,
                                )));
                  },
                  child: Text('Recettes'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child:
                //FutureBuilder(
                //   builder: (context, snapshot) {
                //     var produits = json.decode(snapshot.data.toString());
                GridView.builder(
              itemCount: produits.length,
              itemBuilder: (BuildContext context, int index) {
                // print(produits[index]['nom'].toString());
                // var nom = produits[index]['nom'];
                // print(produits[index]['valeurBool']);
                return InkWell(
                  onTap: () {
                    var nomProduit = produits[index].nomProduit;
                    var imageProduit = produits[index].imageProduit;
                    var prix = produits[index].prix;
                    var description = produits[index].description;
                    var valeurBool = produits[index].valeurBool;
                    var articlePanier = produitSelectionner.length;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsPage(
                                  nomProduit: nomProduit,
                                  imageProduit: imageProduit,
                                  prix: prix,
                                  description: description,
                                  valeurBool: valeurBool,
                                  articlePanier: articlePanier,
                                )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      elevation: 2.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage(
                              produits[index].imageProduit,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  produits[index].nomProduit.toString(),
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${produits[index].prix}' + '€',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                '${produits[index].description}',
                                maxLines: 3,
                                style: TextStyle(
                                  color: Colors.orangeAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                /*Expanded(
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Entrer la quantité',
                                    ),
                                    obscureText: false,

                                    //controller:
                                    // TextEditingController(text: 'Champ obligatoire'),
                                  ),
                                ),
                                */
                                /*
                                Expanded(
                                  child: DropdownButton(
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownValue = newValue!;
                                      });
                                    },
                                    value: dropdownValue,
                                    items: items.map<DropdownMenuItem<String>>(
                                      (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                                */

                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: DropdownButtonFormField(
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color: Colors.orangeAccent),
                                        ),
                                        filled: true,
                                        fillColor: Colors.orangeAccent,
                                      ),
                                      dropdownColor: Colors.orangeAccent,
                                      items: [
                                        DropdownMenuItem(
                                          value: '1',
                                          child: Text('1'),
                                        ),
                                        DropdownMenuItem(
                                          value: '2',
                                          child: Text('2'),
                                        ),
                                      ],
                                      value: quantiter,
                                      onChanged: (value) {
                                        setState(() {
                                          quantiter != value;
                                        });

                                        //recuperer la valeur qui value d'ou le print
                                        print(value);
                                      },
                                    ),

                                    /*
                                    child: DropdownButtonFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        filled: true,
                                        hintText: "Choisissez un motif",
                                        hintStyle: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      value: qte,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      iconSize: 36,
                                      isExpanded: true,
                                      onChanged: (newqte) {
                                        Recup(newqte);
                                      },
                                      items: listMotif.map((valeurqte) {
                                        return DropdownMenuItem(
                                          value: valeurqte,
                                          child: Text(
                                            valeurqte,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    */
                                  ),
                                ),
                                Checkbox(
                                    value: produits[index].valeurBool,
                                    onChanged: (value) {
                                      setState(() {
                                        produits[index].valeurBool = value!;
                                      });
                                      if (value == true) {
                                        fonctionAddition();
                                      } else {
                                        fonctionSoustraction();
                                      }
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 20,
                mainAxisExtent: 350,
                crossAxisCount: 2,
              ),
            ),
            //   },
            //   future: DefaultAssetBundle.of(context)
            //       .loadString("assets/ListeProduits.json"),
            // ),
          ),
        ],
      ),
    );
  }
}
