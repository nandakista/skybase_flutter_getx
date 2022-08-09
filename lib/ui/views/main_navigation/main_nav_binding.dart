import 'package:get/get.dart';
import 'package:skybase/data/data_sources/local/user/user_dao_impl.dart';
import 'package:skybase/data/data_sources/server/auth/auth_api_impl.dart';
import 'package:skybase/data/data_sources/server/user/user_api_impl.dart';
import 'package:skybase/data/repositories/user/user_repository_impl.dart';
import 'package:skybase/ui/views/auth/login/login_controller.dart';
import 'package:skybase/ui/views/main_navigation/main_nav_controller.dart';
import 'package:skybase/ui/views/user/list/user_list_controller.dart';

class MainNavBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainNavController());
    Get.lazyPut(() => LoginController(dataSource: AuthApiImpl()));
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
