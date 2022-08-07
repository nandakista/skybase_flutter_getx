import 'package:get/get.dart';
import 'package:skybase/data/data_sources/server/user/user_api_impl.dart';
import 'package:skybase/data/repositories/user/user_repository_impl.dart';
import 'package:skybase/ui/views/user/detail/user_detail_controller.dart';

class UserDetailBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => UserDetailController(datasource: UserDatasourceImpl()));
    Get.lazyPut(
      () => UserDetailController(
        repository: UserRepositoryImpl(
          apiService: UserApiImpl(),
        ),
      ),
    );
  }
}
