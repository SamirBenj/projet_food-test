import 'dart:io';

class Recipe {
  late final int? recip_id;
  late String? titre;
  late String? img;
  late String? nameUser;
  late String? description;

  Recipe(
    this.recip_id,
    this.titre,
    this.img,
    this.nameUser,
    this.description,
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'recip_id': recip_id,
      'titre': titre,
      'img': img,
      'nameUser': nameUser,
      'description': description
    };

    return map;
  }

  Recipe.fromMap(Map<String, dynamic> map) {
    recip_id = map['recip_id'];
    titre = map['titre'];
    img = map['img'];
    nameUser = map['nameUser'];
  }
}
