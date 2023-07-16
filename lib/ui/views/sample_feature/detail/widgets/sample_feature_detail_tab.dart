import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/app/app_constant.dart';
import 'package:skybase/core/themes/app_colors.dart';
import 'package:skybase/ui/views/sample_feature/detail/component/follower_tab_view.dart';
import 'package:skybase/ui/views/sample_feature/detail/component/following_tab_view.dart';
import 'package:skybase/ui/views/sample_feature/detail/component/repo_tab_view.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_controller.dart';

class SampleFeatureDetailTab extends GetView<SampleFeatureDetailController> {
  const SampleFeatureDetailTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            labelColor: AppColors.primary,
            unselectedLabelColor: Colors.grey,
            indicatorColor: AppColors.accent,
            tabs: [
              Tab(text: 'Repositories'),
              Tab(text: 'Followers'),
              Tab(text: 'Followings'),
            ],
          ),
          Obx(
            () => SizedBox(
              height: AppConst.contentHeight -
                  (controller.headerWidget.value?.height ?? 0) -
                  (controller.detailInfoWidget.value?.height ?? 0) -
                  kTextTabBarHeight,
              child: const TabBarView(
                children: [
                  RepoTabView(),
                  FollowerTabView(),
                  FollowingTabView(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
