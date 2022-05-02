import 'package:flutter/material.dart';
import 'package:projet_food/sqflite/screens/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/SecondePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool isLoggedIn = false;
  @override
  void initState() {
    super.initState();

    //initialisation de la base de donnée
    getUserData();
  }

  //Verification si un utilisateur est déja connecté ou non
  //Si Oui alors on met la variable booleen isLoggedIn à true => navigation vers son profile
  //Si Non alors on met la variable booléen isLoggedIn à false => pas de navigation vers son profile
  void getUserData() async {
    final SharedPreferences sp = await _prefs;
    setState(() {
      var test = sp.getString('email');
      if (test != null) {
        setState(() {
          isLoggedIn = true;
        });
      } else {
        isLoggedIn = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(65, 168, 255, 100),
      body: isLoggedIn
          ? SecondePage()
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Food Delivery',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WelcomePage()));
                      },
                      child: Text(
                        'Commencer',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
