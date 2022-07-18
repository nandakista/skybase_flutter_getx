import 'package:get/get.dart';
import 'package:varcore_flutter_base/ui/views/home/home_binding.dart';
import 'package:varcore_flutter_base/ui/views/home/home_view.dart';

final homeRoute = [
  GetPage(
    name: HomeView.route,
    page: () => const HomeView(),
    binding: HomeBinding(),
    participatesInRootNavigator: true,
  ),
];
