import 'package:flutter_case_4/Model/ibase_model.dart';

class LoginResponseModel extends IBaseModel {
  String? token;

  LoginResponseModel({this.token});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return LoginResponseModel.fromJson(json);
  }
}
