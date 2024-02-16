import 'package:flutter/material.dart';
import 'package:flutter_case_4/Controller/cache_token_manager.dart';
import 'package:flutter_case_4/Model/login_post_model.dart';
import 'package:flutter_case_4/Model/login_response_model.dart';
import 'package:flutter_case_4/Services/services_const.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Services/services.dart';
import 'snackbar.dart';

class LoginController with CacheTokenManager {
  bool isAuthenticated = false;

  LoginController() {
    checkLogin();
  }

  void login(BuildContext context, String username, String password) {
//! context snackbar için kullanılıyor

    username = "eve.holt@reqres.in";
    password = "cityslicka";

    LoginPostModel requestModel =
        LoginPostModel(email: username, password: password);

    _fetchLoginPostRequest(context, requestModel);
  }

  Future<void> checkLogin() async {
    final token = await getToken();
    if (token != null) {
      isAuthenticated = true;
    }
  }

  Future<void> authLogout() async {
    isAuthenticated = await removeToken();
  }

  Future<void> _fetchLoginPostRequest(
      BuildContext context, LoginPostModel requestModel) async {
    LoginResponseModel? request;
    request = await Services.fetchPostData<LoginResponseModel>(
        context: context,
        url: postLogin,
        responseModel: LoginResponseModel(),
        requestModel: requestModel);

    if (request != null) {
      saveToken(request.token!); //! save token

      showSnackBar(context, "Login success");
    } else {
      showSnackBar(context, "Login failed");
    }
  }
}

final LoginProvider =
    Provider((ref) => LoginController());//! login için oluşturduğumuz provider
