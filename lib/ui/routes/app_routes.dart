import 'package:varcore_flutter_base/ui/views/auth/intro/intro_route.dart';
import 'package:varcore_flutter_base/ui/views/auth/login/login_route.dart';
import 'package:varcore_flutter_base/ui/views/auth/splash/splash_view.dart';
import 'package:varcore_flutter_base/ui/views/auth/splash/splash_route.dart';
import 'package:varcore_flutter_base/ui/views/home/home_route.dart';
import 'package:varcore_flutter_base/ui/views/user/detail/user_detail_route.dart';
import 'package:varcore_flutter_base/ui/views/user/list/user_list_route.dart';

class AppPages {
  static const initial = SplashView.route;

  static final routes = [
    ...splashRoute,
    ...introRoute,
    ...loginRoute,
    ...homeRoute,
    ...userListRoute,
    ...userDetailPage,
  ];
}