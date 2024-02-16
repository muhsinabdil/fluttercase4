import 'package:flutter/material.dart';
import 'package:flutter_case_4/Model/login_post_model.dart';
import 'package:flutter_case_4/Model/login_response_model.dart';
import 'package:flutter_case_4/Services/services_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Services/services.dart';
import 'snackbar.dart';

class LoginController {
  void login(BuildContext context, String username, String password) {
//! context snackbar için kullanılıyor

    bool isAuthenticated = false;
    LoginPostModel requestModel =
        LoginPostModel(email: username, password: password);

    if (isAuthenticated) {
      //  showSnackBar(context, "login");
    } else {
      // showSnackBar(context, "Login failed");
    }

    _fetchCategoryPostRequest(context, requestModel);
  }

  Future<void> _fetchCategoryPostRequest(
      BuildContext context, LoginPostModel requestModel) async {
    LoginResponseModel? request;
    request = await Services.fetchPostData<LoginResponseModel>(
        context: context,
        url: postLogin,
        responseModel: LoginResponseModel(),
        requestModel: requestModel);

    if (request != null) {
      //! save token
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', request.token!);
    }
  }
}
