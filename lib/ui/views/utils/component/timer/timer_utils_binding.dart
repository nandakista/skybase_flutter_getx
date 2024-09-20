import 'package:get/get.dart';
import 'package:skybase/ui/views/utils/component/timer/timer_utils_controller.dart';

class TimerUtilsBinding implements Binding {
  @override
  List<Bind> dependencies() => [
    Bind.lazyPut(() => TimerUtilsController()),
  ];
}