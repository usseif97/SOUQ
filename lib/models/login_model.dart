import 'package:souq/models/user_model.dart';

class LoginModel {
  late bool status;
  String? message;
  UserModel? data;

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = UserModel.fromJson(json['data']);
  }
}
