import 'package:get/get.dart';
import 'package:varcore_flutter_base/ui/pages/auth/intro_page.dart';
import 'package:varcore_flutter_base/ui/pages/auth/login/login_binding.dart';
import 'package:varcore_flutter_base/ui/pages/auth/login/login_page.dart';
import 'package:varcore_flutter_base/ui/pages/auth/splash/splash_binding.dart';
import 'package:varcore_flutter_base/ui/pages/auth/splash/splash_page.dart';
import 'package:varcore_flutter_base/ui/pages/home/home_page.dart';

// ignore: non_constant_identifier_names
AppPages() => [
      // Initial
      GetPage(
          name: SplashPage.routeName,
          page: () => const SplashPage(),
          binding: SplashBinding()),
      GetPage(
        name: IntroPage.routeName,
        page: () => const IntroPage(),
      ),
      GetPage(
          name: LoginPage.routeName,
          page: () => const LoginPage(),
          binding: LoginBinding()),
  GetPage(
      name: HomePage.routeName,
      page: () => const HomePage(),
      ),
    ];
