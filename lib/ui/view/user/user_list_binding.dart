import 'package:get/get.dart';
import 'package:varcore_flutter_base/data/data_sources/user/user_api_impl.dart';
import 'package:varcore_flutter_base/ui/view/user/user_list_controller.dart';

class UserListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserListController(datasource: UserApiImpl()));
  }
}