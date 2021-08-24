class UserModel {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late String token;

  // named constructor
  UserModel.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      id = json['id'];
      name = json['name'];
      email = json['email'];
      phone = json['phone'];
      image = json['image'];
      token = json['token'];
    }
  }
}
