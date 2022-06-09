import 'dart:io';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:varcore_flutter_base/core/modules/camera/camera_module.dart';

class ModuleHelper {
  static Future<File?> pickCameraPhoto({
    CameraType cameraType = CameraType.REAR,
    ResolutionPreset resolution = ResolutionPreset.high,
    bool originSize = false,
    bool showInfo = false,
    bool userBorder = false,
  }) async => Get.to(
      () => CameraModule(
        cameraType: cameraType,
        resolutionPreset: resolution,
        originSize: originSize,
        showInfo: showInfo,
        userBorder: userBorder,
      ),
    );
}
