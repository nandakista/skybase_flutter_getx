import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:skybase/core/themes/app_colors.dart';
import 'package:skybase/core/themes/app_style.dart';
import 'package:skybase/data/models/repo/repo.dart';
import 'package:skybase/ui/views/user/detail/user_detail_controller.dart';

class RepoTabView extends GetView<UserDetailController> {
  const RepoTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
        separatorBuilder: (context, _) => const Divider(),
        itemCount: controller.user.value?.repositoryList?.length ?? 0,
        padding: const EdgeInsets.only(top: 8),
        itemBuilder: (_, index) {
          final Repo? repos = controller.user.value!.repositoryList![index];
          return (repos == null)
              ? const Center(
                  child: Text('User belum mem-follow siapapun'),
                )
              : ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      '${repos.owner.avatarUrl}&s=200',
                      scale: 0.1,
                    ),
                  ),
                  title: Text(repos.name.toString(), style: AppStyle.small),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Language: ' + (repos.language ?? '--'),
                        style: AppStyle.normalSmall,
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(right: 80),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.star_border,
                                  size: 16,
                                ),
                                Text(' ${repos.totalStar}',
                                    style: AppStyle.normalSmall),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.remove_red_eye_outlined,
                                    size: 16),
                                Text(' ${repos.totalWatch}',
                                    style: AppStyle.normalSmall),
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset('assets/images/fork.svg',
                                    height: 14,
                                    color: AppColors.systemDarkGrey),
                                Text(' ${repos.totalFork}',
                                    style: AppStyle.normalSmall),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }
}
