import 'package:get/get.dart';
import 'package:varcore_flutter_base/data/data_sources/server/auth/auth_api_impl.dart';
import 'package:varcore_flutter_base/ui/views/auth/login/login_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(dataSource: AuthApiImpl()));
  }
}