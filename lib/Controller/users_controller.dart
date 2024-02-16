// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_case_4/Services/services_const.dart';
import 'package:flutter_case_4/View/users_response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Services/services.dart';
import 'snackbar.dart';

class UsersController extends ChangeNotifier {
  UsersResponseModel usersResponseModel = UsersResponseModel(data: []);
  bool isLoading = false;

  Future<void> fetchUsersRequest(BuildContext context) async {
    isLoading = false;
    UsersResponseModel? request;
    request = await Services.fetchGetData<UsersResponseModel>(
      context: context,
      url: getUsers,
      responseModel: UsersResponseModel(),
    );

    if (request != null) {
      usersResponseModel = request;
      isLoading = true;
    } else {
      showSnackBar(context, "Not Found");
    }
    notifyListeners();
  }
}

final UsersProvider = ChangeNotifierProvider<UsersController>((ref) {
  return UsersController();
});
