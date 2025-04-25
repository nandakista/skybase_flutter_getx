/* Created by
   Varcant
   06/11/2022
   nanda.kista@gmail.com
*/

class TimeLeftData {
  final String hour;
  final String minutes;
  final String second;

  TimeLeftData({
    required this.hour,
    required this.minutes,
    required this.second,
  });
}

class TimerHelper {
  static int startTimer({
    int hours = 0,
    int minutes = 0,
    int seconds = 0,
  }) {
    return seconds + (minutes * 60) + (hours * 60 * 60);
  }

  static String intToTimeLeft(int value) {
    int h, m, s;
    h = value ~/ 3600;
    m = ((value - h * 3600)) ~/ 60;
    s = value - (h * 3600) - (m * 60);

    String hourLeft = convertIntToTimeString(h);
    String minuteLeft = convertIntToTimeString(m);
    String secondsLeft = convertIntToTimeString(s);
    String result = "$hourLeft:$minuteLeft:$secondsLeft";
    return result;
  }

  static TimeLeftData intToTimeLeftData(int value) {
    int h, m, s;
    h = value ~/ 3600;
    m = ((value - h * 3600)) ~/ 60;
    s = value - (h * 3600) - (m * 60);

    String hourLeft = convertIntToTimeString(h);
    String minuteLeft = convertIntToTimeString(m);
    String secondsLeft = convertIntToTimeString(s);

    return TimeLeftData(
      hour: hourLeft,
      minutes: minuteLeft,
      second: secondsLeft,
    );
  }

  static String convertIntToTimeString(int time, {int maxLength = 2}) {
    return time.toString().padLeft(maxLength, '0');
  }
}
