import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/localization/language_const.dart';
import 'package:skybase/core/themes/app_colors.dart';
import 'package:skybase/core/themes/app_style.dart';
import 'package:skybase/data/data_sources/local/user/user_dao_impl.dart';
import 'package:skybase/data/models/user/user.dart';
import 'package:skybase/ui/views/user/list/user_list_controller.dart';
import 'package:skybase/ui/widgets/appbar/custom_appbar.dart';
import 'package:skybase/ui/widgets/pagination/base_pagination_list.dart';

class UserListView extends GetView<UserListController> {
  static const String route = '/user-list';
  const UserListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.secondary(title: International.userList.tr),
      body: PaginationList<User>(
        pagingController: controller.pagingController,
        onRefresh: () => controller.refreshPage(),
        itemBuilder: (BuildContext context, item, int index) {
          return ListTile(
            onTap: () => controller.onChooseUser(user: item),
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                '${item.avatarUrl}&s=200',
                scale: 0.1,
              ),
            ),
            title: Text(item.username.toString()),
            subtitle: Text(
              item.gitUrl.toString(),
              style: AppStyle.small,
            ),
          );
        },
      ),

      // body: RefreshIndicator(
      //   onRefresh: () => Future.sync(
      //     () => controller.pagingController.refresh(),
      //   ),
      //   child: PagedListView<int, User>(
      //     pagingController: controller.pagingController,
      //     builderDelegate: PagedChildBuilderDelegate<User>(
      //       animateTransitions: true,
      //       firstPageProgressIndicatorBuilder: (ctx) => const ShimmerList(),
      //       noItemsFoundIndicatorBuilder: (ctx) => const PaginationEmptyView(),
      //       firstPageErrorIndicatorBuilder: (ctx) => PaginationErrorView(
      //         controller: controller.pagingController,
      //       ),
      //       noMoreItemsIndicatorBuilder: (ctx) => const PaginationMaxItemView(),
      //       newPageErrorIndicatorBuilder: (ctx) =>
      //           const PaginationErrorLoadView(),
      //       itemBuilder: (context, user, index) {
      //         return ListTile(
      //           onTap: () => controller.onChooseUser(user: user),
      //           leading: CircleAvatar(
      //             radius: 30,
      //             backgroundImage: NetworkImage(
      //               '${user.avatarUrl}&s=200',
      //               scale: 0.1,
      //             ),
      //           ),
      //           title: Text(user.username.toString()),
      //           subtitle: Text(
      //             user.gitUrl.toString(),
      //             style: AppStyle.small,
      //           ),
      //         );
      //       },
      //     ),
      //   ),
      // ),
    );
  }
}
