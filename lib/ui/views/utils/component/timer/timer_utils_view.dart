import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/extension/context_extension.dart';
import 'package:skybase/core/modules/timer/timer_helper.dart';
import 'package:skybase/ui/views/utils/component/timer/timer_utils_controller.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';

class TimerUtilsView extends GetView<TimerUtilsController> {
  static const String route = '/sample-timer';
  const TimerUtilsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkyAppBar.primary(title: 'Timer Utility'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text('Sample Timer', style: context.typography.subtitle2),
            const SizedBox(height: 12),
            GetBuilder<TimerUtilsController>(
              id: 'count_down_timer',
              builder: (controller) {
                TimeLeftData timerData = TimerHelper.intToTimeLeftData(
                  controller.timer1.currentTime,
                );
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTimeItem(
                      context: context,
                      time: timerData.hour,
                      title: 'Hour',
                    ),
                    const SizedBox(width: 12),
                    Text(':', style: context.typography.headline1),
                    const SizedBox(width: 12),
                    _buildTimeItem(
                      context: context,
                      time: timerData.minutes,
                      title: 'Minutes',
                    ),
                    const SizedBox(width: 12),
                    Text(':', style: context.typography.headline1),
                    const SizedBox(width: 12),
                    _buildTimeItem(
                      context: context,
                      time: timerData.second,
                      title: 'Second',
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 36),
            Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.currTimeTimer2.value,
                    style: context.typography.headline2,
                  ),
                  Text('Raw Timer', style: context.typography.subtitle3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeItem({
    required BuildContext context,
    required String time,
    required String title,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(time, style: context.typography.headline1),
        Text(title, style: context.typography.subtitle3),
      ],
    );
  }
}
