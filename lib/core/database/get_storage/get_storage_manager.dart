import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:varcore_flutter_base/core/database/get_storage/get_storage_box.dart';

/// ----<Getx Storage>----
///
/// Format -> Key == BoxName,
/// So one box contains one key --> One Box = One Data.
/// If you want to caching dataList, you can use Hive Database, cause the box Hive can contains multiple key & data
class GetStorageManager {
  static GetStorageManager get to => Get.find<GetStorageManager>();
  final _box = Get.find<GetStorage>();

  /// If you want to save Object/Model don't forget to encode toJson
  void write(String name, dynamic value) {
    _box.write(name, value);
  }

  void delete(String name) {
    _box.remove(name);
  }

  /// If you want to get Object/Model don't forget to decode fromJson
  dynamic get(String name) {
    return _box.read(name);
  }

  bool has(String name) {
    return _box.hasData(name);
  }

  String encodeList<T>(List<T> data) {
    return json.encode(data);
  }

  /// Delete all data in every box in storage except CurrentLocale
  logout() async {
    try {
      await GetStorage(GetStorageBox.USERS).erase();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}