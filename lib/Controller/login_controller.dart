import 'package:flutter/material.dart';

import 'snackbar.dart';

class LoginController {
  void login(BuildContext context, String username, String password) {
//! context snackbar için kullanılıyor

    bool isAuthenticated = false;

    if (isAuthenticated) {
      showSnackBar(context, "login ");
    } else {
      showSnackBar(context, "Login failed");
    }
  }
}
