import 'dart:async';

import 'package:get/get.dart';
import 'package:varcore_flutter_base/core/database/get_storage.dart';
import 'package:varcore_flutter_base/core/database/shared_prefs.dart';
import 'package:varcore_flutter_base/data/data_sources/auth/auth_datasource.dart';
import 'package:varcore_flutter_base/data/models/user.dart';
import 'package:varcore_flutter_base/ui/view/auth/intro/intro_page.dart';
import 'package:varcore_flutter_base/ui/view/auth/login/login_page.dart';
import 'package:varcore_flutter_base/ui/view/home/home_page.dart';

class SplashController extends GetxController {
  final AuthDatasource dataSource;
  SplashController({required this.dataSource});

  User? user =  LocalStorage.to.getUser();

  init() async {
    bool? onBoarding = prefs.getBool(KeyPrefs.firstOpen);
    if (onBoarding == null || onBoarding == true) {
      prefs.setBool(KeyPrefs.firstOpen, false);
      Timer(const Duration(seconds: 2), () => Get.toNamed(IntroPage.route));
    } else {
      verifyToken(token: LocalStorage.to.getToken());
    }
  }

  verifyToken({required String? token}) async {
    try {
      await dataSource
          .verifyToken(
              userId: user?.id ?? 0, token: token ?? '')
          .then((res) async  {
        verifyEmail(res.id!, res.email!, res.isActiveEmail);
      });
    } catch (err) {
      Get.offAllNamed(LoginPage.route);
    }
  }

  verifyEmail(int userId, String email, bool? isActiveEmail) {
    if (isActiveEmail ?? false) {
      Get.offAllNamed(HomePage.route);
    } else {
      Get.offAllNamed(LoginPage.route);
    }
  }
}
