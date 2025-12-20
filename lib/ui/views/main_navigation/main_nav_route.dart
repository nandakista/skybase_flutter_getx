import 'package:get/get.dart';
import 'package:skybase/ui/views/main_navigation/main_nav_binding.dart';
import 'package:skybase/ui/views/main_navigation/main_nav_view.dart';

final mainNavRoute = [
  GetPage(
    name: MainNavView.route,
    page: () => const MainNavView(),
    binding: MainNavBinding(),
  ),
];
