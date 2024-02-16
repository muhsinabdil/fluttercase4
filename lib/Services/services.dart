import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Controller/http_status_handles.dart';
import '../Model/ibase_model.dart';
import '../View/snackbar.dart';
import 'package:http/http.dart' as http;

class Services {
  //! http request işlemleri yapılıyor
  static Future<dynamic>? fetchPostData<T extends IBaseModel>(
      {required BuildContext context,
      required String url,
      required IBaseModel responseModel,
      required IBaseModel requestModel}) async {
    var value;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String? token;
      http.Response responseGet = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(requestModel.toJson()));

      String body = responseGet.body;

      httpStatusHandle(
          response: responseGet,
          context: context,
          onSuccess: () {
            if (json.decode(body) is List) {
              value = json
                  .decode(body)
                  .map((e) => responseModel.fromJson(e))
                  .toList()
                  .cast<T>();
            } else if (json.decode(body) is Map) {
              value = responseModel.fromJson(json.decode(body));
            } else {
              value = json.decode(body);
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return value;
  }
}
