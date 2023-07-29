import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/app/app_constant.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_controller.dart';
import 'package:skybase/ui/widgets/sky_image.dart';

class SampleFeatureDetailHeader extends GetView<SampleFeatureDetailController> {
  const SampleFeatureDetailHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: controller.headerKey,
      padding: const EdgeInsets.symmetric(horizontal: AppConst.defaultMargin),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 45,
              child: SkyImage(
                src: '${controller.user.value?.avatarUrl}&s=200',
                borderRadius: BorderRadius.circular(90),
              ),
            ),
            Column(
              children: [
                Text(
                  '${controller.user.value?.repository ?? 0}',
                  style: AppStyle.headline3,
                ),
                const Text('Repository'),
              ],
            ),
            Column(
              children: [
                Text(
                  '${controller.user.value?.followers ?? 0}',
                  style: AppStyle.headline3,
                ),
                const Text('Follower'),
              ],
            ),
            Column(
              children: [
                Text(
                  '${controller.user.value?.following ?? 0}',
                  style: AppStyle.headline3,
                ),
                const Text('Following'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
