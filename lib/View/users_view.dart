import 'package:flutter/material.dart';
import 'package:flutter_case_4/Controller/users_controller.dart';
import 'package:flutter_case_4/View/users_response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Controller/login_controller.dart';
import 'login_view.dart';

class UsersView extends ConsumerStatefulWidget {
  @override
  ConsumerState createState() => _UsersViewState();
}

class _UsersViewState extends ConsumerState<UsersView> {
  @override
  void initState() {
    ref.read(UsersProvider).fetchUsersRequest(context); //! login kontrolü
    super.initState();
  }

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
      body: RefreshIndicator(
        onRefresh: () async {
          ref
              .read(UsersProvider)
              .fetchUsersRequest(context); //! users listesini yenilemek için
        },
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ref.read(UsersProvider).usersResponseModel == null
                ? SizedBox()
                : ListTile(
                    title: Text(ref
                        .read(UsersProvider)
                        .usersResponseModel!
                        .data![index]
                        .email!),
                    subtitle: Text(ref
                        .read(UsersProvider)
                        .usersResponseModel!
                        .data![index]
                        .firstName!),
                  );
          },
        ),
      ),
    );
  }
}
