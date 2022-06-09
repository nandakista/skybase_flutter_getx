import 'package:get/get.dart';
import 'package:varcore_flutter_base/ui/view/auth/splash/splash_binding.dart';
import 'package:varcore_flutter_base/ui/view/auth/splash/splash_page.dart';

final splashRoute = [
  GetPage(
    name: SplashPage.route,
    page: () => const SplashPage(),
    binding: SplashBinding(),
    participatesInRootNavigator: true,
  ),
];
