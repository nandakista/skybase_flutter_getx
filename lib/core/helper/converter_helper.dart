import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

class AppConverter {
  static String toBase64({XFile? imageFile, File? file}) {
    try {
      if (imageFile != null) {
        final bytes = File(imageFile.path).readAsBytesSync();
        String img64Path = base64Encode(bytes);
        return img64Path;
      } else if (file != null) {
        final bytes = File(file.path).readAsBytesSync();
        String file64Path = base64Encode(bytes);
        return file64Path;
      } else {
        return 'Anda belum memilih file';
      }
    } catch (e) {
      debugPrint('toBase64 Exception : ${e.toString()}');
      return e.toString();
    }
  }

  /// Convert string into new string at specific index.
  /// * Example : [oldString] = 'abc', [index] = 2, [newChar] = '$', Result --> a$b
  static String replaceStringAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) +
        newChar +
        oldString.substring(index + 1);
  }

  /// Convert string into new string. Used to hidden string like a email, phone number, etc.
  /// * Example :
  ///
  /// [oldString] = name@email.com,
  ///
  /// [index] = 2,
  ///
  /// [newChar] = *
  ///
  /// --> Result will = na****mail.com
  static String replaceStringRange(String sentence, int start, int end, String newChar) {
    for (int i = start; i < end+1 ; i++) {
      sentence = AppConverter.replaceStringAt(sentence, i, newChar);
    }
    return sentence;
  }
}
