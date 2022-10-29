import 'package:get/get.dart';
import 'package:skybase/data/sources/local/sample_feature/sample_feature_dao_impl.dart';
import 'package:skybase/data/sources/server/auth/auth_api_impl.dart';
import 'package:skybase/data/sources/server/sample_feature/sample_feature_api_impl.dart';
import 'package:skybase/data/repositories/sample_feature_repository_impl.dart';
import 'package:skybase/domain/usecases/get_user.dart';
import 'package:skybase/ui/views/auth/login/login_controller.dart';
import 'package:skybase/ui/views/main_navigation/main_nav_controller.dart';
import 'package:skybase/ui/views/sample_feature/list/sample_feature_list_controller.dart';
import 'package:skybase/ui/views/utils/utils_controller.dart';

class MainNavBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainNavController());
    Get.lazyPut(() => UtilsController());
    Get.lazyPut(() => LoginController(dataSource: AuthApiImpl()));
    Get.lazyPut(
      () => SampleFeatureListController(
        getUsers: GetUsers(
          repository: SampleFeatureRepositoryImpl(
            apiService: SampleFeatureApiImpl(),
            dao: SampleFeatureDaoImpl(),
          ),
        ),
      ),
    );
  }
}
