import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:varcore_flutter_base/core/database/get_storage/storage_box.dart';

class GetStorageHelper {
  static GetStorageHelper get to => Get.find<GetStorageHelper>();
  final _box = Get.find<GetStorage>();

  void write(String name, dynamic value) {
    _box.write(name, value);
  }

  void delete(String name) {
    _box.remove(name);
  }

  dynamic get(String name) {
    return _box.read(name);
  }

  bool has(String name) {
    return _box.hasData(name);
  }

  String encodeList<T>(List<T> data) {
    return json.encode(data);
  }

  logout() async {
    try {
      await GetStorage(GetStorageBox.USERS).erase();
      await GetStorage(GetStorageBox.CURRENT_LOCALE).erase();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}