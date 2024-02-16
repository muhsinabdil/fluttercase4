import 'package:flutter/material.dart';
import 'package:flutter_case_4/View/login_view.dart';
import 'dart:async';

class LogoutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginView()),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Logout'),
      ),
      body: Center(
        child: Text('Logging out...'),
      ),
    );
  }
}
