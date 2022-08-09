import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/localization/language_const.dart';
import 'package:skybase/core/themes/app_colors.dart';
import 'package:skybase/core/themes/app_style.dart';
import 'package:skybase/data/data_sources/local/user/user_dao_impl.dart';
import 'package:skybase/ui/views/user/list/user_list_controller.dart';
import 'package:skybase/ui/widgets/basic_widget.dart';
import 'package:skybase/ui/widgets/custom_app_bar.dart';
import 'package:skybase/ui/widgets/shimmer_list.dart';

class UserListView extends GetView<UserListController> {
  static const String route = '/user-list';
  const UserListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.secondary(title: International.userList.tr),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          UserDaoImpl.find.deleteAll();
        },
        child: const Icon(CupertinoIcons.delete, color: Colors.white),
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.getUser(),
        child: Obx(
          () => (controller.isLoading.isTrue)
              ? const ShimmerList(itemHeight: 60)
              : ListView.separated(
                  separatorBuilder: (context, _) => const Divider(),
                  itemCount: controller.listUser.length,
                  itemBuilder: (_, index) {
                    final user = controller.listUser[index];
                    return ListTile(
                      onTap: () => controller.onChooseUser(user: user),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            NetworkImage('${user.avatarUrl}&s=200', scale: 0.1),
                      ),
                      title: Text(user.username.toString()),
                      subtitle: Text(
                        user.gitUrl.toString(),
                        style: AppStyle.small,
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
