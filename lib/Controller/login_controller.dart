// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_case_4/Controller/cache_token_manager.dart';
import 'package:flutter_case_4/Model/login_post_model.dart';
import 'package:flutter_case_4/Model/login_response_model.dart';
import 'package:flutter_case_4/Services/services_consts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Services/services.dart';
import '../View/users_view.dart';
import 'snackbar.dart';

class LoginController with CacheTokenManager {
  bool isAuthenticated = false;
  bool isLoading = false;
  String? token;

  LoginController() {
    checkLogin();
  }

  void login(BuildContext context, String username, String password) {
//! context snackbar için kullanılıyor

    LoginPostModel requestModel =
        LoginPostModel(email: username, password: password);

    _fetchLoginPostRequest(context, requestModel);
  }

  Future<void> checkLogin() async {
    token = await getToken();
    if (token != null) {
      isAuthenticated = true;
    }
  }

  Future<void> authLogout() async {
    isAuthenticated = await removeToken();
  }

  Future<void> _fetchLoginPostRequest(
      BuildContext context, LoginPostModel requestModel) async {
    isLoading = true;
    LoginResponseModel? request;
    request = await Services.fetchPostData<LoginResponseModel>(
        context: context,
        url: postLogin,
        responseModel: LoginResponseModel(),
        requestModel: requestModel);

    if (request != null) {
      saveToken(request.token!); //! save token
      isLoading = false;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => UsersView()));
      showSnackBar(context, "Login success");
    }
  }
}

final LoginProvider =
    Provider((ref) => LoginController());//! login için oluşturduğumuz provider
