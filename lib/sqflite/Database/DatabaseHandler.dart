import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;

import '../models/UserModel.dart';

class DbHandler {
  static final DbHandler _instance = new DbHandler.internal();
  factory DbHandler() => _instance;
  static Database? _db;

  //Nom de la BDD
  static const String DB_Name = 'new2.db';
  //Nom de la Table
  static const String Table_User = 'user';
  static const int Version = 1;

  static const String C_UserID = 'user_id';
  static const String C_UserName = 'user_name';
  static const String C_Email = 'email';
  static const String C_Password = 'password';

  DbHandler.internal();

  //recherche base de données exisitante
  //Remarque :(la base donées est enregistre localement sur telephone)
  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  //initialisation de la base de données
  initDb() async {
    print("initDB");
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_Name);
    var db = await openDatabase(path, version: Version, onCreate: _onCreate)
        // ignore: invalid_return_type_for_catch_error
        .catchError((onError) => print('init error'));
    return db;
  }

  //creation de la table User => id, user_name, email, password
  _onCreate(Database db, int intVersion) async {
    // await db.execute("CREATE TABLE $Table_User ("
    //     " $C_UserID INT, "
    //     " $C_UserName TEXT, "
    //     " $C_Email TEXT,"
    //     " $C_Password TEXT, "
    //     " PRIMARY KEY ($C_UserID),"
    //     ")");
    await db.execute('''
          CREATE TABLE user(
             user_id INTEGER PRIMARY KEY AUTOINCREMENT,
             user_name TEXT,
             email TEXT,
             password TEXT)
      ''');
  }

  //Creer l'Utilisateur
  Future<int?> saveData(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient?.insert(
      Table_User,
      user.toMap(),
    );
    print(res);
    return res;
  }

  //Permet de se connecter au compte
  Future<UserModel?> getLogin(String user, String password) async {
    var dbClient = await db;
    var res = await dbClient!.rawQuery("SELECT * FROM $Table_User WHERE "
        "$C_Email = '$user' AND "
        "$C_Password = '$password'");

    //si un ligne à etait trouver alors oui il y'a un utilisateur avec le meme mail et password
    if (res.length > 0) {
      print('utilisateur trouvé');
      // print(res.length);
      return new UserModel.fromMap(res.first);
    }
    return null;
  }

  //Recupere les donées d'un utilisateur avec son email il faudra le faire avec son id
  Future<UserModel?> getUserData(String email) async {
    var dbClient = await db;

    //requete afin d'avoir les donées utilisateurs avec le meme mail.
    var res = await dbClient!.rawQuery("SELECT * FROM $Table_User WHERE "
        "$C_Email = '$email'");

    if (res.length > 0) {
      print('worked');
      print(res.length);
      return new UserModel.fromMap(res.first);
    }
    return null;
  }
}
