import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/themes/app_colors.dart';
import 'package:skybase/core/themes/app_style.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/ui/views/sample_feature/detail/component/follower_tab_view.dart';
import 'package:skybase/ui/views/sample_feature/detail/component/following_tab_view.dart';
import 'package:skybase/ui/views/sample_feature/detail/component/repo_tab_view.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_controller.dart';
import 'package:skybase/ui/widgets/base/sky_view.dart';
import 'package:skybase/ui/widgets/colored_status_bar.dart';
import 'package:skybase/ui/widgets/content_wrapper.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_image.dart';

class SampleFeatureDetailView extends GetView<SampleFeatureDetailController> {
  static const String route = '/user-detail';
  const SampleFeatureDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredStatusBar(
      child: Scaffold(
        appBar: SkyAppBar.primary(title: controller.user.value?.username),
        body: Obx(
          () => SkyView(
            loadingEnabled: controller.isLoading.isTrue,
            errorEnabled: controller.isError.isTrue,
            onRetry: () => controller.onRefresh(),
            isFitScreen: true,
            child: Column(
              children: [
                _buildHeader(controller.user.value),
                _buildDetailInfo(controller.user.value),
                Container(height: 1000, color: Colors.blue,),
                Container(height: 1000, color: Colors.red,)
                // _tabComponent(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildHeader(SampleFeature? user) {
    return ContentWrapper(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 45,
            child: SkyImage(
              url: '${user?.avatarUrl}&s=200',
              borderRadius: BorderRadius.circular(90),
            ),
          ),
          Column(
            children: [
              Text(
                '${user?.repository ?? 0}',
                style: AppStyle.headline3,
              ),
              const Text('Repository'),
            ],
          ),
          Column(
            children: [
              Text(
                '${user?.followers ?? 0}',
                style: AppStyle.headline3,
              ),
              const Text('Follower'),
            ],
          ),
          Column(
            children: [
              Text(
                '${user?.following ?? 0}',
                style: AppStyle.headline3,
              ),
              const Text('Following'),
            ],
          ),
        ],
      ),
    );
  }

  _buildDetailInfo(SampleFeature? user) {
    return ContentWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Text(user?.name ?? '--', style: AppStyle.headline4),
          Text(user?.bio ?? '--'),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.location_city),
              Text(' ${user?.company ?? '--'}'),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.location_on),
              Text(' ${user?.location ?? '--'}'),
            ],
          ),
        ],
      ),
    );
  }

  _tabComponent() {
    return DefaultTabController(
      length: 3,
      child: Expanded(
        child: Column(
          children: const [
            TabBar(
              labelColor: AppColors.primary,
              unselectedLabelColor: Colors.grey,
              indicatorColor: AppColors.accent,
              tabs: [
                Tab(text: 'Repositories'),
                Tab(text: 'Followers'),
                Tab(text: 'Followings'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  RepoTabView(),
                  FollowerTabView(),
                  FollowingTabView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
