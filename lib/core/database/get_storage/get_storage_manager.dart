import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:skybase/core/database/get_storage/get_storage_key.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/

/// ----<Getx Storage>----
///
/// Format -> Key == BoxName,
/// So one box contains one key --> One Box = One Data.
/// If you want to caching dataList, you can use Hive Database, cause the box Hive can contains multiple key & data
class GetStorageManager {
  static GetStorageManager get find => Get.find<GetStorageManager>();
  final _box = Get.find<GetStorage>();

  /// If you want to save Object/Model don't forget to encode toJson
  void save(String name, dynamic value) {
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

  /// Get object with await
  dynamic getAwait(String name) async {
    return await _box.read(name);
  }

  /// Delete all data in every box in storage except CurrentLocale
  logout() async {
    try {
      await GetStorage(GetStorageKey.USERS).erase();
      save(GetStorageKey.FIRST_INSTALL, false);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}