import 'package:get/get.dart';
import 'package:varcore_flutter_base/data/data_sources/auth/auth_datasource_impl.dart';
import 'package:varcore_flutter_base/ui/pages/auth/login/login_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(dataSource: AuthDatasourceImpl()));
  }
}