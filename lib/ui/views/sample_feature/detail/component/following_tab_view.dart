import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/domain/entities/sample_feature/sample_feature.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_controller.dart';
import 'package:skybase/ui/widgets/sky_image.dart';

class FollowingTabView extends GetView<SampleFeatureDetailController> {
  const FollowingTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (controller.dataObj.value?.followingList ?? []).isEmpty
          ? Center(
              child: Text('txt_no_following'.tr),
            )
          : ListView.separated(
              separatorBuilder: (context, _) => const Divider(),
              itemCount: controller.dataObj.value?.followingList?.length ?? 0,
              itemBuilder: (_, index) {
                final SampleFeature? user =
                    controller.dataObj.value?.followingList![index];
                return ListTile(
                  leading: SkyImage(
                    size: 30,
                    shapeImage: ShapeImage.circle,
                    src: '${user?.avatarUrl}&s=200',
                    // onTap: () => controller.onChooseUser(user: user),
                  ),
                  title: Text(user?.username ?? ''),
                  subtitle: Text(
                    user?.gitUrl ?? '',
                    style: AppStyle.body2,
                  ),
                );
              },
            ),
    );
  }
}
