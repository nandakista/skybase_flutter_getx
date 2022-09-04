import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/localization/language_const.dart';
import 'package:skybase/core/themes/app_colors.dart';
import 'package:skybase/core/themes/app_style.dart';
import 'package:skybase/data/data_sources/local/user/user_dao_impl.dart';
import 'package:skybase/data/models/user/user.dart';
import 'package:skybase/ui/views/user/list/user_list_controller.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/base/sky_pagination_view.dart';

class UserListView extends GetView<UserListController> {
  static const String route = '/user-list';
  const UserListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkyAppBar.secondary(title: International.userList.tr),
      body: SkyPaginationView<User>(
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
    );
  }
}
