import 'package:flutter/material.dart';

class ConnexionComptePage extends StatefulWidget {
  const ConnexionComptePage({Key? key}) : super(key: key);

  @override
  State<ConnexionComptePage> createState() => _ConnexionComptePageState();
}

class _ConnexionComptePageState extends State<ConnexionComptePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Log in',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Enter a email',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Enter a password',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Log in'),
              style: ElevatedButton.styleFrom(
                primary: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: "Welcome To"),
                  TextSpan(text: "sign up"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
