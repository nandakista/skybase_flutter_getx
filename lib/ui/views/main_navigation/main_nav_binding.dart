import 'package:get/get.dart';
import 'package:skybase/ui/views/auth/login/login_binding.dart';
import 'package:skybase/ui/views/main_navigation/main_nav_controller.dart';
import 'package:skybase/ui/views/sample_feature/list/sample_feature_list_binding.dart';
import 'package:skybase/ui/views/utils/utils_binding.dart';

class MainNavBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainNavController());
    UtilsBinding().dependencies();
    LoginBinding().dependencies();
    SampleFeatureListBinding().dependencies();
  }
}
