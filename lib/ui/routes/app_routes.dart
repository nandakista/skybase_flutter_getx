import 'package:skybase/ui/views/intro/intro_route.dart';
import 'package:skybase/ui/views/login/login_route.dart';
import 'package:skybase/ui/views/profile/profile_route.dart';
import 'package:skybase/ui/views/settings/setting_route.dart';
import 'package:skybase/ui/views/splash/splash_route.dart';
import 'package:skybase/ui/views/splash/splash_view.dart';
import 'package:skybase/ui/views/main_navigation/main_nav_route.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_route.dart';
import 'package:skybase/ui/views/sample_feature/list/sample_feature_list_route.dart';
import 'package:skybase/ui/views/utils/component/timer/timer_utils_route.dart';

class AppPages {
  static const initial = SplashView.route;

  static final routes = [
    ...splashRoute,
    ...introRoute,
    ...loginRoute,
    ...mainNavRoute,
    ...sampleFeatureRoute,
    ...sampleFeatureDetailPage,
    ...timerUtilsRoute,
    ...profileRoute,
    ...settingRoute,
  ];
}