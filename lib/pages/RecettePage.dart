import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

class RecettePage extends StatefulWidget {
  final articlePanier;
  final produitSelectionner;
  const RecettePage({Key? key, this.articlePanier, this.produitSelectionner})
      : super(key: key);

  @override
  State<RecettePage> createState() => _RecettePageState();
}

class _RecettePageState extends State<RecettePage> {
  /* void ajouterRecette() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        title: Text("Ajouter une recette"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              autofocus: true,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Ajouter"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardRecette(String recette) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
        padding: EdgeInsets.all(5.0),
        child: ListTile(
          title: Text("$recette"),
          onLongPress: () {},
        ),
      ),
    );
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* floatingActionButton: FloatingActionButton(
        onPressed: ajouterRecette,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.orange,
      ),
      */
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
      /*SingleChildScrollView(
        child: Column(
          children: <Widget>[
            cardRecette("recette 1"),
          ],
        ),
      ),
      */
    );
  }
}
