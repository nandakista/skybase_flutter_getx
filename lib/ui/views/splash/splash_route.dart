import 'package:get/get.dart';
import 'package:skybase/ui/views/splash/splash_view.dart';

final splashRoute = [
  GetPage(
    name: SplashView.route,
    page: () => const SplashView(),
    participatesInRootNavigator: true,
  ),
];
