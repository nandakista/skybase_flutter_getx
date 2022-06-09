import 'package:get/get.dart';
import 'package:varcore_flutter_base/ui/view/home/home_page.dart';

final homeRoute = [
  GetPage(
    name: HomePage.route,
    page: () => const HomePage(),
    participatesInRootNavigator: true,
  ),
];
