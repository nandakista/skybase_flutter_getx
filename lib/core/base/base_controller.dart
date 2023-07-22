import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:skybase/core/cache_manager/cache_model_converter.dart';
import 'package:skybase/core/database/get_storage/get_storage_manager.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
abstract class BaseController<T> extends GetxController {
  GetStorageManager storage = GetStorageManager.find;

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxBool isError = false.obs;

  final dataObj = Rxn<T>();

  String get storageName;

  String get cacheId;

  /// **NOTE:**
  /// call this [refreshPage] instead of [onRefresh] when you need to dispose anything
  void refreshPage() {}

  void onRefresh() {
    storage.delete(storageName);
    dataObj.value = null;
    refreshPage();
  }

  void showLoading() {
    if (dataObj.value == null) {
      isLoading.value = true;
      isError.value = false;
      errorMessage.value = '';
    }
  }

  void hideLoading() => isLoading.value = false;

  void showError(String message) {
    errorMessage.value = message;
    isError.value = true;
  }

  void loadData(Function() onLoad) {
    onLoad();
  }

  /// **NOTE:**
  /// make sure you call this method at initial state,
  /// before you call method [saveCacheAndFinish]
  Future<void> getCache(Function() onLoad) async {
    var cache = storage.get(storageName);
    if (storage.has(storageName) && cache.toString().isNotEmpty) {
      if (cacheId == getId(cache)) {
        dataObj.value = CacheModelConverter<T>().fromJson(cache);
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
  Future<void> saveCacheAndFinish({required T data}) async {
    try {
      await storage.save(storageName, CacheModelConverter<T>().toJson(data));
      finishLoadData(data: data);
    } catch (e) {
      debugPrint('Failed save cache, $e');
      showError(e.toString());
    }
  }

  /// **NOTE:**
  /// call this [finishLoadData] instead [saveCacheAndFinish] if the data
  /// is not require to saved in local data
  finishLoadData({required T data}) {
    dataObj.value = data;
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
