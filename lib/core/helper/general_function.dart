import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

class AppFunction {
  static Future<Uint8List> compressBytes(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 1920,
      minWidth: 1080,
      quality: 20,
    );
    debugPrint(list.length.toString());
    debugPrint(result.length.toString());
    return result;
  }

  static Future<File> compressImage({
    required File file,
    required int limit,
  }) async {
    var minLimit = 1000000;
    if (limit < minLimit) limit = minLimit;
    var size = file.lengthSync();
    while (size >= limit) {
      var result = await FlutterImageCompress.compressWithFile(
        file.absolute.path,
        minWidth: 1024,
        minHeight: 1024,
        quality: 80,
      );
      var image = img.decodeJpg(result!)!;
      File(file.path).writeAsBytesSync(img.encodePng(image));
      size = file.lengthSync();
    }
    return file;
  }

  // ----------------------------------------------------------------------------------------
  //                                 Video Image Picker
  // ----------------------------------------------------------------------------------------

  static Future<File?> imagePicker(
    ImageSource source,
    ImagePicker imagePicker,
  ) async {
    XFile? pickedFile = await imagePicker.pickImage(
      source: source,
      imageQuality: 40,
    );
    return File(pickedFile!.path);
  }

  static Future<File?> pickVideo(
    ImageSource source,
    ImagePicker filePicker,
  ) async {
    XFile? pickedFile = await filePicker.pickVideo(
      source: source,
      preferredCameraDevice: CameraDevice.rear,
      maxDuration: const Duration(seconds: 20),
    );
    return File(pickedFile!.path);
  }
}
