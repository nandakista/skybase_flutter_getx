import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/ui/views/main_navigation/main_nav_controller.dart';
import 'package:skybase/ui/views/profile/profile_view.dart';
import 'package:skybase/ui/views/sample_feature/list/sample_feature_list_view.dart';
import 'package:skybase/ui/views/utils/utils_view.dart';
import 'package:skybase/ui/widgets/colored_status_bar.dart';
import 'package:skybase/ui/widgets/sky_box.dart';

class MainNavView extends GetView<MainNavController> {
  static const String route = '/home';
  const MainNavView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredStatusBar(
        brightness: Brightness.dark,
        child: SafeArea(
          child: PageView(
            controller: controller.pageController,
            onPageChanged: (index) => controller.index.value = index,
            children: const [
              SampleFeatureListView(),
              UtilsView(),
              ProfileView(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => SkyBox(
          borderRadius: 0,
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          borderColor: Colors.transparent,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 5,
              blurRadius: 3,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          child: BottomNavigationBar(
            currentIndex: controller.index.value,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            onTap: (index) {
              controller.pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            },
            items: [
              BottomNavigationBarItem(
                icon: const Icon(CupertinoIcons.home),
                label: 'txt_users'.tr,
              ),
              BottomNavigationBarItem(
                icon: const Icon(CupertinoIcons.slider_horizontal_3),
                label: 'txt_utility'.tr,
              ),
              BottomNavigationBarItem(
                icon: const Icon(CupertinoIcons.profile_circled),
                label: 'txt_profile'.tr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
