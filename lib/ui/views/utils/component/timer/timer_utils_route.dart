import 'package:get/get.dart';
import 'package:skybase/ui/views/utils/component/timer/timer_utils_binding.dart';
import 'package:skybase/ui/views/utils/component/timer/timer_utils_view.dart';

final timerUtilsRoute = [
  GetPage(
    name: TimerUtilsView.route,
    page: () => const TimerUtilsView(),
    binding: TimerUtilsBinding(),
  ),
];
