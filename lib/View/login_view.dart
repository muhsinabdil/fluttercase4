import 'package:flutter/material.dart';
import 'package:flutter_case_4/Controller/login_controller.dart';
import 'package:flutter_case_4/View/users_view.dart';
import 'package:flutter_case_4/View/view_consts.dart';

import '../Controller/cache_token_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginView extends ConsumerStatefulWidget {
  @override
  ConsumerState createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: kDefaultPadding),
                SizedBox(
                  width: screenSize.width * 0.8,
                  height: screenSize.width * 0.8,
                  child: Image.asset("assets/images/logo.jpg"),
                ),
                SizedBox(height: kDefaultPadding),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: kSecondTextColor),
                  decoration: InputDecoration(
                    // Set fill color
                    filled: true,
                    border: const OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(kDefaultRadius)),
                      borderSide: BorderSide.none,
                    ),

                    labelText: "Username",
                    labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: kSecondTextColor), // Set label text color
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _username = value!;
                  },
                ),
                SizedBox(height: kDefaultPadding),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: kSecondTextColor),
                  decoration: InputDecoration(
                    // Set fill color
                    filled: true,
                    border: const OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(kDefaultRadius)),
                      borderSide: BorderSide.none,
                    ),

                    labelText: "Password",
                    labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: kSecondTextColor), // Set label text color
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                ),
                SizedBox(height: kDefaultPadding),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      //! login işlemleri yapılacak
                      ref
                          .read(LoginProvider)
                          .login(context, _username, _password);
                    }
                  },
                  child: Ink(
                    width: screenSize.width * 0.5,
                    height: screenSize.height * 0.08,
                    decoration: BoxDecoration(
                      color: kDefaultButtonColor,
                      borderRadius: BorderRadius.circular(kDefaultRadius),
                    ),
                    child: Center(
                      child: Text(
                        'Login',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
