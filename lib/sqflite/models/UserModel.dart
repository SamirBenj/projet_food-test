class UserModel {
  late final int? user_id;
  late String? username;
  late String? email;
  late String? password;

  UserModel(
    this.user_id,
    this.username,
    this.email,
    this.password,
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'user_id': user_id,
      'user_name': username,
      'email': email,
      'password': password
    };

    return map;
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    user_id = map['user_id'];
    username = map['user_name'];
    email = map['email'];
    password = map['password'];
  }
}
