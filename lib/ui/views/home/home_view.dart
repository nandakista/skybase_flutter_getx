import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:varcore_flutter_base/ui/views/auth/intro/intro_view.dart';
import 'package:varcore_flutter_base/ui/views/auth/login/login_view.dart';
import 'package:varcore_flutter_base/ui/views/home/home_controller.dart';
import 'package:varcore_flutter_base/ui/views/user/list/user_list_view.dart';
import 'package:varcore_flutter_base/ui/views/utils/utils_view.dart';
import 'package:varcore_flutter_base/ui/widgets/basic_widget.dart';
import 'package:varcore_flutter_base/ui/widgets/colored_status_bar.dart';

class HomeView extends GetView<HomeController> {
  static const String route = '/home';
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredStatusBar(
        child: SafeArea(
          child: DoubleBack(
            child: PageView(
              controller: controller.pageController,
              onPageChanged: (index) => controller.index.value = index,
              children: const [
                UserListView(),
                IntroView(),
                LoginView(),
                UtilsView(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        ()=> BottomNavigationBar(
          currentIndex: controller.index.value,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            controller.pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'Menu 1',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.arrow_turn_down_right),
              label: 'Menu 2',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.map),
              label: 'Menu 3',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.book),
              label: 'Menu 4',
            ),
          ],
        ),
      ),
    );
  }
}
