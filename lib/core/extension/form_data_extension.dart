import 'dart:io';

import 'package:dio/dio.dart';
import 'package:skybase/core/extension/list_extension.dart';

extension FileExtension on File? {
  MultipartFile? get toFormDataFile {
    return this != null ? MultipartFile.fromFileSync(this!.path) : null;
  }
}

extension FileNullListExtension on List<File>? {
  List<MultipartFile>? get toFormDataFiles {
    if (!isNullOrEmpty) {
      return this!.map((e) => MultipartFile.fromFileSync(e.path)).toList();
    } else {
      return null;
    }
  }
}
