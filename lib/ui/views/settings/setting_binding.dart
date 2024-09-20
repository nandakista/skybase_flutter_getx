import 'package:get/get.dart';

import 'setting_controller.dart';

class SettingBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => SettingController()),
      ];
}
