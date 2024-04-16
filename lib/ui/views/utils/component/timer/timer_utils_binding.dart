import 'package:get/get.dart';
import 'package:skybase/ui/views/utils/component/timer/timer_utils_controller.dart';

class TimerUtilsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TimerUtilsController());
  }
}