import 'package:souq/models/user_model.dart';

class LoginModel {
  late bool status;
  late String message;
  UserModel? data;

  // normal constructor
  /*LoginModel({
    required this.status,
    required this.message,
    required this.data,
  });*/

  // named constructor
  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? UserModel.fromJson(json['data']) : null);
  }
}
