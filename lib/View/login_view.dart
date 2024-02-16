import 'package:flutter/material.dart';
import 'package:flutter_case_4/Controller/login_controller.dart';
import 'package:flutter_case_4/View/users_view.dart';

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
  void initState() {
    super.initState();

    //! check login
    bool _login = ref.read(LoginProvider).isAuthenticated;
    if (_login) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  UsersView())); //! giriş yapılmış ise kullanıcılar sayfasına yönlendir
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Please enter a username';
                  }
                  return null;
                },
                onSaved: (value) {
                  _username = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null) {
                    return 'Please enter a password';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    //! login logic here
                    LoginController().login(context, _username, _password);
                  }
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
