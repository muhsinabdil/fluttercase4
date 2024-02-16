import 'package:flutter_case_4/Model/ibase_model.dart';

class LoginPostModel extends IBaseModel {
  String? email;
  String? password;

  LoginPostModel({this.email, this.password});

  LoginPostModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return LoginPostModel.fromJson(json); //! gelen map çevrildi
  }
}
