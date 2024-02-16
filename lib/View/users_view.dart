import 'package:flutter/material.dart';
import 'package:flutter_case_4/Controller/users_controller.dart';
import 'package:flutter_case_4/View/custom_shimmer.dart';
import 'package:flutter_case_4/View/logout_view.dart';
import 'package:flutter_case_4/View/users_response_model.dart';
import 'package:flutter_case_4/View/view_consts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Controller/login_controller.dart';
import '../Controller/snackbar.dart';
import 'login_view.dart';

class UsersView extends ConsumerStatefulWidget {
  @override
  ConsumerState createState() => _UsersViewState();
}

class _UsersViewState extends ConsumerState<UsersView> {
  UsersResponseModel? usersModel;
  UsersResponseModel? usersTempModel;
  ScrollController? scroollController;
  int pageNum = 1;
  bool isPageLoading = true;
  @override
  void initState() {
    ref.read(UsersProvider).fetchUsersRequest(context, pageNum);
    scroollController = new ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    scroollController!.removeListener(_scrollListener);
    super.dispose();
  }

  _scrollListener() {
    if (scroollController!.position.pixels ==
            scroollController!.position.maxScrollExtent &&
        !isPageLoading) {
      pageNum++;
      ref.read(UsersProvider).fetchUsersRequest(context, pageNum);
      isPageLoading = ref.read(UsersProvider).isLoading;
    }
  }

  @override
  Widget build(BuildContext context) {
    isPageLoading = ref.read(UsersProvider).isLoading;
    if (pageNum > 1 && !isPageLoading) {
      usersTempModel = ref.watch(UsersProvider).usersResponseModel;
      usersModel!.data!.addAll(usersTempModel!.data!);
      usersTempModel = null;
    } else if (pageNum == 1) {
      usersModel = ref.watch(UsersProvider).usersResponseModel;
    }

    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        title: Text(
          'Users',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: kSecondTextColor),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ref
                  .read(LoginProvider)
                  .authLogout(); //!çıkış yapılıp token siliniyor

              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LogoutView()));
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          pageNum = 1;
          await ref.read(UsersProvider).fetchUsersRequest(context, pageNum);
        },
        child: ListView.builder(
          controller: scroollController,
          itemCount: usersModel!.data == null ? 5 : usersModel!.data!.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return usersModel!.data!.isEmpty
                ? CustomShimmer(
                    width: screenSize.width * 0.9,
                    height: screenSize.height * 0.1,
                  )
                : Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: Container(
                      padding: EdgeInsets.all(kDefaultPadding),
                      decoration: BoxDecoration(
                        color: kDefaultListColor,
                        borderRadius: BorderRadius.circular(kDefaultRadius),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(usersModel!.data![index].avatar!),
                            radius: screenSize.width * 0.1,
                          ),
                          SizedBox(
                            width: kDefaultPadding,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                usersModel!.data![index].firstName! +
                                    " " +
                                    usersModel!.data![index].lastName!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: kDefaultTextColor),
                              ),
                              Text(
                                usersModel!.data![index].email!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: kDefaultTextColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
