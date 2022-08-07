import 'dart:io';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:skybase/core/modules/camera/camera_module.dart';

class ModuleHelper {
  /// Pick Image from [ModuleHelper.pickImage] avoid to crash when picked image using low-end devices.
  ///
  /// * With *false* value from [originSize] which means the picked image will crop into square.
  /// If you want to get original size of image, please set it into *true*.
  ///
  /// * You can hide gallery picked by set [fromGallery] to *false*.
  ///
  /// * The picked image will compress into 1080 size,
  /// if you want to get original size please set [originSize] to *true*
  ///
  /// * True in [useBorder] will show the border in camera preview.
  /// It can help user when they pick face, id card, etc.
  ///
  /// * [showInfo] to true will show information of picked image like size, path.
  static Future<File?> pickImage({
    CameraType cameraType = CameraType.REAR,
    ResolutionPreset resolution = ResolutionPreset.high,
    bool originSize = false,
    bool showInfo = false,
    bool useBorder = false,
    bool fromGallery = true,
  }) async => Get.to(
      () => CameraModule(
        cameraType: cameraType,
        resolutionPreset: resolution,
        originSize: originSize,
        showInfo: showInfo,
        useBorder: useBorder, fromGallery: fromGallery,
      ),
    );
}
