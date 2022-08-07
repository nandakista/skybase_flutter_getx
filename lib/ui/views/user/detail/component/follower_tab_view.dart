import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/themes/app_style.dart';
import 'package:skybase/data/models/user/user.dart';
import 'package:skybase/ui/views/user/detail/user_detail_controller.dart';

class FollowerTabView extends GetView<UserDetailController> {
  const FollowerTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, _) => const Divider(),
      itemCount: controller.user.value?.followersList?.length ?? 0,
      itemBuilder: (_, index) {
        final User? user = controller.user.value!.followersList![index];
        return (user == null)
            ? const Center(
                child: Text('Tidak ada follower'),
              )
            : ListTile(
                // onTap: () => controller.onChooseUser(user: user),
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
    );
  }
}
