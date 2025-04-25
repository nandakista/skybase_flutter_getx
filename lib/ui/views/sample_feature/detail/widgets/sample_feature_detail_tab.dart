import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/config/themes/app_colors.dart';
import 'package:skybase/core/extension/size_extension.dart';
import 'package:skybase/ui/views/sample_feature/detail/component/follower_tab_view.dart';
import 'package:skybase/ui/views/sample_feature/detail/component/following_tab_view.dart';
import 'package:skybase/ui/views/sample_feature/detail/component/repo_tab_view.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_controller.dart';

class SampleFeatureDetailTab extends GetView<SampleFeatureDetailController> {
  const SampleFeatureDetailTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            labelColor: AppColors.primary,
            unselectedLabelColor: Colors.grey,
            indicatorColor: AppColors.secondary,
            tabs: [
              Tab(text: 'Repositories'),
              Tab(text: 'Followers'),
              Tab(text: 'Followings'),
            ],
          ),
          SizedBox(
            height: 45.h,
            child: const TabBarView(
              children: [
                RepoTabView(),
                FollowerTabView(),
                FollowingTabView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
