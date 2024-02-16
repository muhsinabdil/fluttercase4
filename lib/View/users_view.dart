import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Controller/login_controller.dart';

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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Users'),
            ElevatedButton(
                onPressed: () {
                  //  ref.read(LoginProvider).logout();
                },
                child: Text("Logout"))
          ],
        ),
      ),
    );
  }
}
