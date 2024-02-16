import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Controller/login_controller.dart';
import 'login_view.dart';

class UsersView extends ConsumerStatefulWidget {
  @override
  ConsumerState createState() => _UsersViewState();
}

class _UsersViewState extends ConsumerState<UsersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        actions: [
          IconButton(
            onPressed: () {
              ref
                  .read(LoginProvider)
                  .authLogout(); //!çıkış yapılıp token siliniyor
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginView()));
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Users'),
          ],
        ),
      ),
    );
  }
}
