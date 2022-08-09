import 'package:get/get.dart';
import 'package:skybase/data/data_sources/local/user/user_dao_impl.dart';
import 'package:skybase/data/data_sources/server/user/user_api_impl.dart';
import 'package:skybase/data/repositories/user/user_repository_impl.dart';
import 'package:skybase/ui/views/user/list/user_list_controller.dart';

class UserListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
          () => UserListController(
        repository: UserRepositoryImpl(
          apiService: UserApiImpl(),
          dao: UserDaoImpl(),
        ),
      ),
    );
  }
}
