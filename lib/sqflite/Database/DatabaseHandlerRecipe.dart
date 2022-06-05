import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;

import '../models/RecipeModel.dart';

class DbHandler {
  static final DbHandler _instance = new DbHandler.internal();
  factory DbHandler() => _instance;
  static Database? _db;

  //Nom de la BDD
  static const String DB_Name = 'Recette.db';
  //Nom de la Table
  static const String Table_Recip = 'recip';
  static const int Version = 1;

  static const String C_RecipID = 'recip_id';
  static const String C_Titre = 'titre';
  static const String C_Image = 'img';
  static const String C_NameUser = 'nameUser';
  static const String C_Description = 'description';

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
          CREATE TABLE recip(
             recip_id INTEGER PRIMARY KEY AUTOINCREMENT,
             titre TEXT,
             img TEXT,
             nameUser TEXT,
             description TEXT)
      ''');
  }

  //Creer une recette
  Future<int?> saveData(Recipe recipe) async {
    var dbRecette = await db;
    var res = await dbRecette?.insert(
      Table_Recip,
      recipe.toMap(),
    );
    print(res);
    return res;
  }
}
