import 'package:get/get.dart';
import 'package:skybase/core/helper/snackbar_helper.dart';
import 'package:skybase/core/modules/timer/timer_helper.dart';
import 'package:skybase/core/modules/timer/timer_module.dart';

class TimerUtilsController extends GetxController {
  TimerModule timer1 = TimerModule();
  TimerModule timer2 = TimerModule();

  final currTimeTimer2 = 'Waiting...'.obs;

  @override
  void onInit() {
    _startTimer();
    Future.delayed(const Duration(seconds: 2)).then((value) => _startTimer2());
    super.onInit();
  }

  /// Timer 1
  void _startTimer() {
    timer1.startTimer(
      time: TimerHelper.startTimer(hours: 3),
      onChanged: (int time) {
        update(['count_down_timer']);
      },
    );
  }

  /// Timer 2
  void _startTimer2() {
    timer2.startTimer(
      time: TimerHelper.startTimer(seconds: 3),
      onStart: (item) {
        currTimeTimer2.value = item.toString();
      },
      onChanged: (int time) {
        currTimeTimer2.value = time.toString();
      },
      onFinished: () {
        currTimeTimer2.value = 'Timer End';
        SnackBarHelper.normal(message: 'Timer 2 is done');
      },
    );
  }

  @override
  void onClose() {
    timer1.stopTimer();
    timer2.stopTimer();
    super.onClose();
  }
}
