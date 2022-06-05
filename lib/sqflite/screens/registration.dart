import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:projet_food/sqflite/Database/DatabaseHandler.dart';
import 'package:projet_food/sqflite/models/UserModel.dart';
import 'package:projet_food/sqflite/screens/login.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formRegistrationKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController userId = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordAgainController = TextEditingController();
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHandler();
  }

  signUp() async {
    String name = nameController.text;
    String mail = mailController.text;
    String password = passwordController.text;
    String passwordAgain = passwordAgainController.text;
    // String uid = userId.text;

    if (_formRegistrationKey.currentState!.validate()) {
      if (password != passwordAgain) {
        print('password mismatch');
      } else {
        _formRegistrationKey.currentState!.save();

        UserModel uModel = UserModel(null, name, mail, password);
        await DbHandler().saveData(uModel).then((userData) {
          print("Successfully Saved");

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => LoginPage(),
              ));
        }).catchError((error) {
          print(error);
          print(context.toString() + "Error: Data Save Fail");

          final snack = SnackBar(
            content: const Text('Un problme est survenue ❌'),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
          setState(() {
            mailController.text = "";
            passwordAgainController.text = "";
            passwordController.text = "";
            userId.text = "";
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formRegistrationKey,
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: TextFormField(
                //     onSaved: (val) => userId.text = val!,
                //     // validator: (value) {
                //     //   if (value == null || value.isEmpty) {
                //     //     return 'Please enter userId';
                //     //   }
                //     //   return null;
                //     // },
                //     controller: userId,
                //     keyboardType: TextInputType.name,
                //     decoration: InputDecoration(
                //       enabledBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.white),
                //         borderRadius: BorderRadius.circular(20),
                //       ),
                //       filled: true,
                //       label: Text(
                //         'UserId',
                //         style: TextStyle(
                //           color: Colors.black,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Inscrivez-vous dès maintenant 👋',
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onSaved: (val) => nameController.text = val!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Entrer votre nom';
                      }
                      return null;
                    },
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      label: Text(
                        'nom',
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
                    onSaved: (val) => mailController.text = val!,
                    validator: (value) =>
                        EmailValidator.validate(value.toString())
                            ? null
                            : "Entrer un email valide",
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
                    onSaved: (val) => passwordController.text = val!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Entrer un Mot de passe';
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
                        'Mot de passe',
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
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    onSaved: (val) => passwordAgainController.text = val!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirmer votre mot de passe';
                      }
                      return null;
                    },
                    controller: passwordAgainController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      label: Text(
                        'Confirmation Mot de passe',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => signUp(),
                  child: Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(76, 0, 0, 0),
                          spreadRadius: 0.2,
                          blurRadius: 10,
                        )
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                    child: Text(
                      'Valider',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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
