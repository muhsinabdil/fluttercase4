// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_case_4/Services/services_const.dart';
import 'package:flutter_case_4/View/users_response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Services/services.dart';
import 'snackbar.dart';

class UsersController {
  UsersResponseModel? usersResponseModel;

  Future<void> fetchUsersRequest(BuildContext context) async {
    UsersResponseModel? request;
    request = await Services.fetchGetData<UsersResponseModel>(
      context: context,
      url: postLogin,
      responseModel: UsersResponseModel(),
    );

    if (request != null) {
      usersResponseModel = request;
    } else {
      showSnackBar(context, "Users fetch failed");
    }
  }
}

final UsersProvider =
    Provider((ref) => UsersController());//! login için oluşturduğumuz provider
