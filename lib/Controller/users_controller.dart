// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_case_4/Services/services_consts.dart';
import 'package:flutter_case_4/Model/users_response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Services/services.dart';
import 'snackbar.dart';

class UsersController extends ChangeNotifier {
  UsersResponseModel usersResponseModel = UsersResponseModel(data: []);
  bool isLoading = false;

  Future<void> fetchUsersRequest(BuildContext context, int page) async {
    isLoading = true;
    UsersResponseModel? request;
    request = await Services.fetchGetData<UsersResponseModel>(
      context: context,
      url: getUsers + page.toString(),
      responseModel: UsersResponseModel(),
    );

    if (request != null) {
      usersResponseModel = request;
      isLoading = false;
      request = null;
    } else {
      showSnackBar(context, "Not Found");
    }
    notifyListeners();
  }
}

final UsersProvider = ChangeNotifierProvider<UsersController>((ref) {
  return UsersController();
});
