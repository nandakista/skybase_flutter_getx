import 'package:flutter/services.dart';

class AppOrientation {
  static Future<void> lock(List<DeviceOrientation> orientations) {
    return SystemChrome.setPreferredOrientations(orientations);
  }
}