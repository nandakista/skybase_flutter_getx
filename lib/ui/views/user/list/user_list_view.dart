import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:varcore_flutter_base/core/themes/app_colors.dart';
import 'package:varcore_flutter_base/core/themes/app_style.dart';
import 'package:varcore_flutter_base/data/data_sources/local/user/user_dao.dart';
import 'package:varcore_flutter_base/ui/views/user/list/user_list_controller.dart';
import 'package:varcore_flutter_base/ui/widgets/basic_widget.dart';
import 'package:varcore_flutter_base/ui/widgets/custom_app_bar.dart';

class UserListView extends GetView<UserListController> {
  static const String route = '/user-list';
  const UserListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(title: 'List User'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          UserDao.to.deleteAll();
        },
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.getUser(),
        child: Obx(
              () => (controller.isLoading.isTrue)
              ? platformLoadingIndicator()
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