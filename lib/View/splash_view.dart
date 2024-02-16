// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_case_4/Controller/login_controller.dart';
import 'package:flutter_case_4/View/login_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'users_view.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();
    controlToLogin();
  }

  Future<void> controlToLogin() async {
    //! Login kontrolü yapılıyor
    await ref.read(LoginProvider).checkLogin(); //! login kontrolü
    if (ref.read(LoginProvider).isAuthenticated) {
      await Future.delayed(const Duration(seconds: 1));

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => UsersView()));
    } else {
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginView()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            SizedBox(
              width: screenSize.width * 0.5,
              height: screenSize.width * 0.5,
              child: Image.asset("assets/images/logo.jpg"),
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
