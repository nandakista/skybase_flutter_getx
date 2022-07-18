import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:varcore_flutter_base/core/app/app_constant.dart';
import 'package:varcore_flutter_base/core/themes/app_colors.dart';
import 'package:varcore_flutter_base/core/themes/app_style.dart';
import 'package:varcore_flutter_base/data/models/user/user.dart';
import 'package:varcore_flutter_base/ui/views/user/detail/component/follower_tab_view.dart';
import 'package:varcore_flutter_base/ui/views/user/detail/component/following_tab_view.dart';
import 'package:varcore_flutter_base/ui/views/user/detail/component/repo_tab_view.dart';
import 'package:varcore_flutter_base/ui/views/user/detail/user_detail_controller.dart';
import 'package:varcore_flutter_base/ui/widgets/basic_widget.dart';
import 'package:varcore_flutter_base/ui/widgets/custom_app_bar.dart';

class UserDetailView extends GetView<UserDetailController> {
  static const String route = '/user-detail';
  const UserDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          title: '${controller.user.value?.username}',
          centerTitle: false,
        ),
      ),
      body: SafeArea(
        child: Obx(() => controller.isLoading.isTrue
            ? platformLoadingIndicator()
            : Obx(
                () => ListView(
                  children: [
                    _buildHeader(controller.user.value),
                    _buildDetailInfo(controller.user.value),
                    _tabComponent(),
                  ],
                ),
              )),
      ),
    );
  }

  _buildHeader(User? user) {
    return Padding(
      key: controller.headerKey,
      padding: const EdgeInsets.symmetric(horizontal: AppConst.defaultMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 45,
            backgroundImage:
                NetworkImage('${user?.avatarUrl}&s=200', scale: 0.1),
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

  _buildDetailInfo(User? user) {
    return Padding(
      key: controller.detailInfoKey,
      padding: const EdgeInsets.symmetric(horizontal: AppConst.defaultMargin),
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
          Obx(() => SizedBox(
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
              )),
        ],
      ),
    );
  }
}
