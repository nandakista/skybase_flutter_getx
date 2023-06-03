import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skybase/core/database/secure_storage/secure_storage_manager.dart';
import 'package:skybase/core/helper/sky_snackbar.dart';
import 'package:skybase/core/network/api_request.dart';

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

  // Download File
  static Future<File> downloadFile(
      {required String url, bool useToken = false, name}) async {
    var fileName = 'downloaded_file';
    if (name != null) {
      fileName = name;
    }
    try {
      if (useToken) {
        String? token = await SecureStorageManager.find.getToken();
        headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
      } else {
        headers.clear();
      }
      final rs = await Dio().get<List<int>>(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          headers: headers,
        ),
      );
      var dir = await getApplicationDocumentsDirectory();
      File file = File('${dir.path}/$fileName.pdf');
      File urlFile = await file.writeAsBytes(rs.data!);
      return urlFile;
    } catch (e) {
      debugPrint('Error : $e');
      throw Exception('Error opening url file');
    }
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

  static Future<File?> takeVideo(
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

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double sh = size.height; // for convenient shortage
    double sw = size.width; // for convenient shortage
    double cornerSide = sh * 0.07; // desirable value for corners side

    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Path path = Path()
      ..moveTo(cornerSide, 0)
      ..quadraticBezierTo(0, 0, 0, cornerSide)
      ..moveTo(0, sh - cornerSide)
      ..quadraticBezierTo(0, sh, cornerSide, sh)
      ..moveTo(sw - cornerSide, sh)
      ..quadraticBezierTo(sw, sh, sw, sh - cornerSide)
      ..moveTo(sw, cornerSide)
      ..quadraticBezierTo(sw, 0, sw - cornerSide, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BorderPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BorderPainter oldDelegate) => false;
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
