import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/ui/views/auth/intro/intro_view.dart';
import 'package:skybase/ui/views/auth/login/login_view.dart';
import 'package:skybase/ui/views/order/order_tab.dart';
import 'package:skybase/ui/views/home/home_controller.dart';
import 'package:skybase/ui/views/user/list/user_list_view.dart';
import 'package:skybase/ui/views/utils/utils_view.dart';
import 'package:skybase/ui/widgets/basic_widget.dart';
import 'package:skybase/ui/widgets/colored_status_bar.dart';

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
                FilterTabView(),
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
              label: 'Users',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.arrow_turn_down_right),
              label: 'Intro',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.map),
              label: 'Login',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.book),
              label: 'Utility',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.filter_list_rounded),
              label: 'Filter',
            ),
          ],
        ),
      ),
    );
  }
}
