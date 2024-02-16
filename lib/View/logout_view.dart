import 'package:flutter/material.dart';
import 'package:flutter_case_4/View/login_view.dart';
import 'dart:async';

import 'view_consts.dart';

class LogoutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginView()),
      );
    });

    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: kDefaultPadding),
          SizedBox(
            width: screenSize.width * 0.5,
            height: screenSize.width * 0.5,
            child: Image.asset("assets/images/logo.jpg"),
          ),
          SizedBox(height: screenSize.height * 0.1),
          CircularProgressIndicator(),
          SizedBox(height: screenSize.height * 0.1),
          Text(
            'Logout...',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: kSecondTextColor),
          ),
        ],
      )),
    );
  }
}
