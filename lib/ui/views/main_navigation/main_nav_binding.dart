import 'package:get/get.dart';
import 'package:skybase/ui/views/main_navigation/main_nav_controller.dart';
import 'package:skybase/ui/views/profile/profile_binding.dart';
import 'package:skybase/ui/views/sample_feature/list/sample_feature_list_binding.dart';
import 'package:skybase/ui/views/utils/utils_binding.dart';

class MainNavBinding implements Binding {
  @override
  List<Bind> dependencies() => [
    Bind.lazyPut(() => MainNavController()),
    ...UtilsBinding().dependencies(),
    ...ProfileBinding().dependencies(),
    ...SampleFeatureListBinding().dependencies(),
  ];
}
