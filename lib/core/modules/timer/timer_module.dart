import 'dart:async';

import 'package:flutter/foundation.dart';

/* Created by
   Varcant
   06/11/2022
   nanda.kista@gmail.com
*/
class TimerModule {
  static const String tag = 'TIMER_MODULE';

  int currentTime = 0;
  Timer? timer;
  String? savedUpdateId;
  int? savedTime;
  void Function(int currentTime)? onStartTimer;
  void Function()? onFinishedTimer;
  void Function(int currentTime)? onChangedTimer;

  void startTimer({
    required int time,
    Duration? intervalTime,
    void Function(int currentTime)? onStart,
    void Function()? onFinished,
    void Function(int currentTime)? onChanged,
  }) {
    // Save timer info
    savedTime = time;
    onStartTimer = onStart;
    onFinishedTimer = onFinished;
    onChangedTimer = onChanged;

    _setCurrentTime(time);
    if (onStart != null) onStart(time);
    timer = Timer.periodic(
      intervalTime ?? const Duration(seconds: 1),
      (Timer timerP) {
        if (currentTime == 0) {
          _stopTimerP(timerP);
          if (onFinished != null) onFinished();
        } else {
          _setCurrentTime(currentTime -= 1);
          if (onChanged != null) onChanged(currentTime);
          savedTime = currentTime;
        }
        if (kDebugMode) debugPrint('TIMER UPDATE: | $currentTime');
      },
    );
  }

  void _setCurrentTime(int time) {
    currentTime = time;
  }

  void _stopTimerP(Timer timerP) {
    timerP.cancel();
    stopTimer();
  }

  /// Stop timer if there is another timer running,
  /// then immediately start new timer.
  /// So no duplicated timer running
  void restartTimer({
    required String updateId,
    required int time,
    Duration? intervalTime,
    void Function(int currentTime)? onStart,
    void Function()? onFinished,
    void Function(int currentTime)? onChanged,
  }) {
    debugPrint('$tag: $savedUpdateId | restart timer');
    if (currentTime != 0) {
      stopTimer();
    }
    startTimer(
      time: time,
      intervalTime: intervalTime,
      onStart: onStart,
      onFinished: onFinished,
      onChanged: onChanged,
    );
  }

  void stopTimer() {
    timer?.cancel();
  }

  void pauseTimer() {
    timer?.cancel();
  }

  void resumeTimer() {
    startTimer(
      time: savedTime ?? 0,
      onChanged: onChangedTimer,
      onFinished: onFinishedTimer,
      onStart: onStartTimer,
    );
  }
}
