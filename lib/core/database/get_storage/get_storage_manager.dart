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
class GetStorageManager {
  static GetStorageManager get find => Get.find<GetStorageManager>();
  final _box = Get.find<GetStorage>();

  /// If you want to save Object/Model don't forget to encode toJson
  Future<void> save(String name, dynamic value) async {
    await _box.write(name, value);
  }

  Future<void> delete(String name) async {
    await _box.remove(name);
  }

  /// If you want to get Object/Model don't forget to decode fromJson
  dynamic get<T>(String name) {
    return _box.read<T>(name);
  }

  bool has(String name) {
    return _box.hasData(name);
  }

  String encodeList<T>(List<T> data) {
    return json.encode(data);
  }

  List<T> decodeList<T>(String data) {
    return json.decode(data);
  }

  dynamic getAwait(String name) async {
    return await _box.read(name);
  }

  void logout() async {
    try {
      await GetStorage(GetStorageKey.STORAGE_NAME).erase();
      save(GetStorageKey.FIRST_INSTALL, false);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
