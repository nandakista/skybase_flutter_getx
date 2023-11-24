import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_controller.dart';
import 'package:skybase/ui/widgets/sky_image.dart';

class FollowerTabView extends GetView<SampleFeatureDetailController> {
  const FollowerTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (controller.dataObj.value!.followersList!.isEmpty)
          ? const Center(
              child: Text('Tidak ada follower'),
            )
          : ListView.separated(
              separatorBuilder: (context, _) => const Divider(),
              itemCount: controller.dataObj.value?.followersList?.length ?? 0,
              itemBuilder: (_, index) {
                final SampleFeature? user =
                    controller.dataObj.value?.followersList![index];
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
