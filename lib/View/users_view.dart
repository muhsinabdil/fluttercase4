import 'package:flutter/material.dart';
import 'package:flutter_case_4/Controller/users_controller.dart';
import 'package:flutter_case_4/View/custom_shimmer.dart';
import 'package:flutter_case_4/View/users_response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Controller/login_controller.dart';
import 'login_view.dart';

class UsersView extends ConsumerStatefulWidget {
  @override
  ConsumerState createState() => _UsersViewState();
}

class _UsersViewState extends ConsumerState<UsersView> {
  UsersResponseModel? usersModel;

  @override
  void initState() {
    ref.read(UsersProvider).fetchUsersRequest(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    usersModel = ref.watch(UsersProvider).usersResponseModel;

    Size screenSize = MediaQuery.of(context).size;
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
          await ref.read(UsersProvider).fetchUsersRequest(context);
        },
        child: ListView.builder(
          itemCount: usersModel == null ? 5 : usersModel!.data!.length,
          itemBuilder: (context, index) {
            return usersModel == null
                ? CustomShimmer(
                    height: screenSize.height * 0.1,
                  )
                : usersModel!.data!.isEmpty
                    ? CustomShimmer(
                        height: screenSize.height * 0.1,
                      )
                    : ListTile(
                        title: Text(usersModel!.data![index].firstName! +
                            " " +
                            usersModel!.data![index].lastName!),
                        subtitle: Text("subtitle"),
                      );
          },
        ),
      ),
    );
  }
}
