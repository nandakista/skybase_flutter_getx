import 'package:get/get.dart';
import 'package:skybase/ui/views/settings/setting_view.dart';

import 'setting_binding.dart';

final settingRoute = [
  GetPage(
      name: SettingView.route,
      page: () => const SettingView(),
      binding: SettingBinding(),
  ),
];