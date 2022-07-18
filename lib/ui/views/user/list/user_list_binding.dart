import 'package:get/get.dart';
import 'package:varcore_flutter_base/data/data_sources/server/user/user_api_impl.dart';
import 'package:varcore_flutter_base/data/repositories/user/user_repository_impl.dart';
import 'package:varcore_flutter_base/ui/views/user/list/user_list_controller.dart';

class UserListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => UserListController(
        repository: UserRepositoryImpl(
          apiService: UserApiImpl(),
        ),
      ),
    );
  }
}
