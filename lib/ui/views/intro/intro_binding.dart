import 'package:get/get.dart';

import 'intro_controller.dart';

class IntroBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => IntroController()),
      ];
}
