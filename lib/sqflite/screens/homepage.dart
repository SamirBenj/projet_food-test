import 'package:flutter/material.dart';
import 'package:projet_food/sqflite/screens/welcome.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  String? email;
  String? username;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  //recupere les données de l'utilisateur lors du login
  void getUserData() async {
    final SharedPreferences sp = await _pref;
    setState(() {
      email = sp.getString('email');
      username = sp.getString('username');
    });
    print('email sp:' + email!);
    print('username sp: ' + username!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bonjour ',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                  ),
                ),
                Text(
                  email.toString(),
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' !',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
