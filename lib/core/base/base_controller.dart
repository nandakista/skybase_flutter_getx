import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:skybase/data/sources/local/cached_model_converter.dart';
import 'package:skybase/core/database/get_storage/get_storage_manager.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
abstract class BaseController<T> extends GetxController {
  GetStorageManager storage = GetStorageManager.find;

  RxBool loadingStatus = false.obs;
  RxString errorMessage = ''.obs;

  final dataObj = Rxn<T>();
  RxList<T> dataList = RxList<T>([]);

  bool get isLoading => loadingStatus.isTrue;
  bool get isError => errorMessage.value.isNotEmpty;
  bool get isEmpty => dataList.isEmpty && dataObj.value == null;
  bool get isSuccess => !isEmpty && !isError && !isLoading;

  String get cachedKey;

  String get cachedId;

  /// **NOTE:**
  /// call this [refreshPage] instead of [onRefresh] when you need to dispose anything
  void refreshPage() {}

  void onRefresh() {
    storage.delete(cachedKey);
    dataObj.value = null;
    refreshPage();
  }

  void showLoading() {
    if (dataObj.value == null && dataList.isEmpty) {
      loadingStatus.value = true;
      errorMessage.value = '';
    }
  }

  void hideLoading() => loadingStatus.value = false;

  void showError(String message) {
    errorMessage.value = message;
  }

  void loadData(Function() onLoad) {
    onLoad();
  }

  /// **NOTE:**
  /// make sure you call this method at initial state,
  /// before you call method [saveCacheAndFinish]
  Future<void> getCache(Function() onLoad) async {
    var cache = storage.get(cachedKey);
    if (storage.has(cachedKey) && cache.toString().isNotEmpty) {
      if (cache is String) {
        dataList.value = List<T>.from(
          (json.decode(cache) as List).map(
            (x) => CachedModelConverter<T>().fromJson(x),
          ),
        );
      } else {
        if (cachedId == getId(cache)) {
          dataObj.value = CachedModelConverter<T>().fromJson(cache);
        }
      }
    }
    onLoad();
  }

  String getId(Map<String, dynamic> cache) {
    return (cache['id']).toString();
  }

  /// **NOTE:**
  /// call this to finish the load data,
  /// don't need to call [finishLoadData] anymore
  Future<void> saveCacheAndFinish({
    T? data,
    List<T> list = const [],
  }) async {
    try {
      if (data != null) {
        await storage.save(cachedKey, CachedModelConverter<T>().toJson(data));
      }
      if (list.isNotEmpty) {
        await storage.save(cachedKey, json.encode(list));
      }
      finishLoadData(data: data, list: list);
    } catch (e) {
      debugPrint('Failed save cache, $e');
      showError(e.toString());
    }
  }

  /// **NOTE:**
  /// call this [finishLoadData] instead [saveCacheAndFinish] if the data
  /// is not require to saved in local data
  finishLoadData({
    T? data,
    List<T> list = const [],
  }) {
    if (data != null) dataObj.value = data;
    if (list.isNotEmpty) dataList.value = list;
  }

  /// **NOTE:**
  /// call this [closePage] instead of [onClose] when you need to dispose anything
  void closePage() {}

  @override
  void onClose() {
    closePage();
    super.onClose();
  }
}
