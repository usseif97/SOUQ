import 'package:flutter/cupertino.dart';

class UserModel {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late String token;
  late int points;
  late int credit;

  // normal constructor
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.token,
    required this.points,
    required this.credit,
  });

  // named constructor
  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    token = json['token'];
    points = json['points'];
    credit = json['credit'];
  }
}
