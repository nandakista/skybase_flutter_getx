import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/ui/views/profile/component/repository/profile_repository_controller.dart';
import 'package:skybase/ui/widgets/base/state_view.dart';
import 'package:skybase/ui/widgets/shimmer/sample_feature/shimmer_sample_feature_list.dart';
import 'package:skybase/ui/widgets/sky_image.dart';

class ProfileRepositoryView extends GetView<ProfileRepositoryController> {
  const ProfileRepositoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => StateView.component(
        loadingEnabled: controller.isLoading,
        errorEnabled: controller.isError,
        emptyEnabled: controller.isEmpty,
        onRetry: () => controller.onRefresh(),
        loadingView: const ShimmerSampleFeatureList(),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.dataList.length,
          itemBuilder: (context, index) {
            final item = controller.dataList[index];
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: SkyImage(
                shapeImage: ShapeImage.circle,
                size: 30,
                src: '${item.owner.avatarUrl}&s=200',
              ),
              title: Text(item.name.toString(), style: AppStyle.body2),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Language: ${item.language ?? '--'}',
                    style: AppStyle.body3,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.star_border,
                            size: 16,
                          ),
                          Text(
                            ' ${item.totalStar}',
                            style: AppStyle.body3,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.remove_red_eye_outlined,
                            size: 16,
                          ),
                          Text(
                            ' ${item.totalWatch}',
                            style: AppStyle.body3,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SkyImage(
                            src: 'assets/images/ic_fork.svg',
                            height: 14,
                            color: Colors.grey,
                          ),
                          Text(
                            ' ${item.totalFork}',
                            style: AppStyle.body3,
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
