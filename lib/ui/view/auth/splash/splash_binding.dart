import 'package:get/get.dart';
import 'package:varcore_flutter_base/data/data_sources/auth/auth_api_impl.dart';
import 'package:varcore_flutter_base/ui/view/auth/splash/splash_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(dataSource: AuthApiImpl()));
  }
}