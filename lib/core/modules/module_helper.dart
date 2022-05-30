import 'dart:io';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:varcore_flutter_base/core/modules/camera/camera_module.dart';

class MyModule {
  static Future<File?> pickCameraPhoto({
    CameraType cameraType = CameraType.REAR,
    ResolutionPreset resolution = ResolutionPreset.high,
    bool showInfo = false,
  }) async {
    return Get.to(
          () => CameraModule(
        cameraType: cameraType,
        resolutionPreset: resolution,
        showInfo: showInfo,
      ),
    );
  }
}
