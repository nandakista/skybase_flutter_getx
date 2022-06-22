import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:varcore_flutter_base/ui/view/user/user_list_controller.dart';
import 'package:varcore_flutter_base/ui/widgets/basic_widget.dart';

class UserListPage extends GetView<UserListController> {
  static const String route = '/user-list';
  const UserListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          onPress: () => Get.back(),
          title: 'List User',
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.getUser(),
        child: Obx(
          () => ListView.separated(
            separatorBuilder: (context, _) => const Divider(),
            itemCount: controller.listUser.length,
            itemBuilder: (_, index) {
              final user = controller.listUser[index];
              return ListTile(
                onTap: () => controller.onChooseUser(user: user),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    user.avatar.toString(),
                  ),
                ),
                title: Text('${user.firstName} ${user.lastName}'),
                subtitle: Text(user.email.toString()),
              );
            },
          ),
        ),
      ),
    );
  }
}
