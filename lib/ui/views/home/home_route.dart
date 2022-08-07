import 'package:get/get.dart';
import 'package:skybase/ui/views/home/home_binding.dart';
import 'package:skybase/ui/views/home/home_view.dart';

final homeRoute = [
  GetPage(
    name: HomeView.route,
    page: () => const HomeView(),
    binding: HomeBinding(),
    participatesInRootNavigator: true,
  ),
];
