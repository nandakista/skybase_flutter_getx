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

  void refreshData() {}

  void onRefresh() {
    storage.delete(storageName);
    refreshData();
  }

  void showLoading() {
    isLoading.value = true;
    isError.value = false;
    errorMessage.value = '';
  }

  void hideLoading() => isLoading.value = false;

  void showError(String message) {
    errorMessage.value = message;
    isError.value = true;
  }

  String get storageName;

  String get cacheId;

  void loadData(Function() onLoad) {
    onLoad();
  }

  /// **NOTE:**
  /// make sure you call this method at initial state, before you call method [saveCache]
  Future<T?> getCache(Function() onLoad) async {
    var cache = storage.get(storageName);
    if (storage.has(storageName) && cache.toString().isNotEmpty) {
      if (cacheId == getId(cache)) {
        return CacheModelConverter<T>().fromJson(cache);
      }
    }
    onLoad();
    return null;
  }

  String getId(Map<String, dynamic> cache) {
    return (cache['id']).toString();
  }

  Future<void> saveCache({required T data}) async {
    try {
      await storage.save(storageName, CacheModelConverter<T>().toJson(data));
    } catch (e) {
      showError(e.toString());
      debugPrint('Error save cache data $e');
    }
  }
}
