import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class AppConverter {
  static String toBase64({XFile? imageFile, File? file}) {
    try {
      if (imageFile != null) {
        final bytes = File(imageFile.path).readAsBytesSync();
        String _img64Path = base64Encode(bytes);
        debugPrint('toBase64 Success');
        return _img64Path;
      } else if (file != null) {
        final bytes = File(file.path).readAsBytesSync();
        String _file64Path = base64Encode(bytes);
        debugPrint('toBase64 Success');
        return _file64Path;
      } else {
        return 'Anda belum memilih file';
      }
    } catch (e) {
      debugPrint('toBase64 Exception : ${e.toString()}');
      return e.toString();
    }
  }

  static String snakeCaseToNormal(String input){
    return input.replaceAll("_", " ").toLowerCase().split(" ").map((e) => "${e[0].toUpperCase()}${e.substring(1)}").join(" ");
  }

  static String toSnakeCase(String input){
    return input.replaceAll(" ", "_").toLowerCase().split(" ").map((e) => "${e[0].toLowerCase()}${e.substring(1)}").join(" ");
  }

  static String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) + newChar + oldString.substring(index + 1);
  }

  static String toIDR({required int amount}){
    return NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0).format(amount);
  }
}
