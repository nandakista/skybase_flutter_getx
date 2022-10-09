import 'package:get/get.dart';
import 'package:skybase/data/sources/server/auth/auth_api_impl.dart';
import 'package:skybase/ui/views/auth/login/login_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(dataSource: AuthApiImpl()));
  }
}