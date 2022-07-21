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

extension StringExtension on String {
  String capitalize() {
    return split(' ')
        .map((e) => '${e[0].toUpperCase()}${e.substring(1)}')
        .join(' ');
  }

  String toSnakeCase() {
    return replaceAll(' ', '_')
        .toLowerCase()
        .split(' ')
        .map((e) => '${e[0].toLowerCase()}${e.substring(1)}')
        .join(' ');
  }

  String snakeToNormalCase() {
    return replaceAll('_', ' ')
        .toLowerCase()
        .split(' ')
        .map((e) => '${e[0]}${e.substring(1)}')
        .join(' ');
  }

  /// Convert string Indonesian Currency to int.
  ///
  /// The required format string is "Rp 0.000..."
  /// the return is [Int]
  /// * Example : Rp 1.000 (String) --> 1000
  int fromIDR() {
    return int.tryParse(substring(3, length).replaceAll('.', '')) ?? 0;
  }
}

extension IntExtension on int {

  /// Convert int to currency format.
  /// * Example : 1000 (int) --> Rp 1.000 (String)
  String toIDR() {
    return NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
        .format(this);
  }
}
