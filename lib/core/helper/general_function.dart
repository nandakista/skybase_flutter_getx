import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:varcore_flutter_base/core/database/get_storage.dart';
import 'package:varcore_flutter_base/core/network/api_request.dart';

class AppFunction {
  static Future<String> getFileSize(String filepath, int decimals) async {
    var file = File(filepath);
    int bytes = await file.length();
    debugPrint("Path : $filepath");
    debugPrint("Size : $bytes");
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }

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

  static Future<File?> compressImage(
      {required File file, required String targetPath}) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      minWidth: 1024,
      minHeight: 1024,
      quality: 80,
    );
    debugPrint(file.lengthSync().toString());
    debugPrint(result?.lengthSync().toString());
    return result;
  }

  // Download File
  static Future<File> downloadFile({required String url, bool useToken = false, name}) async {
    var fileName = "downloaded_file";
    if (name != null) {
      fileName = name;
    }
    try {
      if (useToken) {
        var apiToken = LocalStorage.to.isLoggedIn() ? LocalStorage.to.getToken() : null;
        headers[HttpHeaders.authorizationHeader] = "Bearer $apiToken";
      } else {
        headers.clear();
      }
      final rs = await Dio().get<List<int>>(url,
          options: Options(responseType: ResponseType.bytes, headers: headers));
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/" + fileName + ".pdf");
      File urlFile = await file.writeAsBytes(rs.data!);
      return urlFile;
    } catch (e) {
      debugPrint("Error : $e");
      throw Exception("Error opening url file");
    }
  }

  static Future<String> downloadFilePath(String url, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = "${directory.path}/$fileName";
    await Dio().download(url, filePath);
    return filePath;
  }

  static openFile({required String url, String? fileName}) async {
    final name = fileName ?? url.split("/").last;
    final file = await downloadFilePath(url, name);
    debugPrint("Path : $file");
    OpenFile.open(file);
  }

  // ----------------------------------------------------------------------------------------
  //                                 File/Image Picker
  // ----------------------------------------------------------------------------------------

  static Future<File?> pickGalleryPhoto(
      ImageSource source, ImagePicker imagePicker) async {
    XFile? _pickedFile = await imagePicker.pickImage(
      source: source,
      imageQuality: 40,
    );
    return File(_pickedFile!.path);
  }

  static Future<File?> takeVideo(
    ImageSource source,
    ImagePicker filePicker,
  ) async {
    XFile? _pickedFile = await filePicker.pickVideo(
      source: source,
      preferredCameraDevice: CameraDevice.rear,
      maxDuration: const Duration(seconds: 20),
    );
    return File(_pickedFile!.path);
  }

  static Future<File?> pickFile(BuildContext context, String type) async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ["pdf"]);
    if (result != null) {
      File file = File(result.files.single.path!);
      return file;
    }
    return null;
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
