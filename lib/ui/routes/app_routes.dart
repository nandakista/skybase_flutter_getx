import 'package:varcore_flutter_base/ui/view/auth/intro/intro_route.dart';
import 'package:varcore_flutter_base/ui/view/auth/login/login_route.dart';
import 'package:varcore_flutter_base/ui/view/auth/splash/splash_page.dart';
import 'package:varcore_flutter_base/ui/view/auth/splash/splash_route.dart';
import 'package:varcore_flutter_base/ui/view/home/home_route.dart';

class AppPages {
  static const initial = SplashPage.route;

  static final routes = [
    ...splashRoute,
    ...introRoute,
    ...loginRoute,
    ...homeRoute,
  ];
}