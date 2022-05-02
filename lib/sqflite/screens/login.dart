import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:projet_food/pages/SecondePage.dart';
import 'package:projet_food/sqflite/models/UserModel.dart';
import 'package:projet_food/sqflite/screens/homepage.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../Database/DatabaseHandler.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  final _formLoginKey = GlobalKey<FormState>();

  // TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var dbHelper;

  @override
  void initState() {
    super.initState();
    //Initialisation de la Base de données
    dbHelper = DbHandler();
  }

  login() async {
    String mail = mailController.text;
    String password = passwordController.text;

    //Enregistrement des champs email, password de l'utilisateur
    if (_formLoginKey.currentState!.validate()) {
      _formLoginKey.currentState!.save();

      await DbHandler().getLogin(mail, password).then((data) {
        // print(data);
        if (data != null) {
          //Enregistre les donnée utilisateur afin de garder la session active
          setSP(data);
          //Il navigera à la page de "profile" de l'utilisateur
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => SecondePage(),
            ),
            (Route<dynamic> route) => false,
          );
        } else {
          //Afichage d'une erreur car la connection au compte à échoué
          final snack = SnackBar(
            content: const Text('Incorrect ❌'),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
          setState(() {
            mailController.text = "";
            passwordController.text = "";
          });
        }
      });
    }
  }

  //Enregistre la session utlisateur c'est-à-dire son email et son username
  //Cela est possible grâçe au pacquet SharedPreference qui permet de garder sur le smartphone des données local.
  Future setSP(UserModel user) async {
    final SharedPreferences sp = await _pref;
    sp.setString("email", user.email ?? '');
    sp.setString("username", user.username ?? '');
    print("sharedinng preferencinggg");
    print(user.email);
    sp.setString("password", user.password ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formLoginKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onSaved: (value) => mailController.text = value!,
                    validator: (value) =>
                        EmailValidator.validate(value.toString())
                            ? null
                            : "Please enter a good mail",
                    keyboardType: TextInputType.emailAddress,
                    controller: mailController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      label: Text(
                        'E-Mail',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onSaved: ((newValue) =>
                        passwordController.text = newValue!),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                    controller: passwordController,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      label: Text(
                        'Password',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      login();
                    },
                    child: Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Registration',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
