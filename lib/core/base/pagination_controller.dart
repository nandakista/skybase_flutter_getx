import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skybase/core/cache_manager/cache_model_converter.dart';
import 'package:skybase/core/database/get_storage/get_storage_manager.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
abstract class PaginationController<T> extends GetxController {
  GetStorageManager storage = GetStorageManager.find;

  int perPage = 20;
  int page = 1;
  final pagingController = PagingController<int, T>(firstPageKey: 0);

  RxList<T> dataList = RxList<T>([]);

  String get storageName;

  /// **NOTE:**
  /// call this [refreshPage] instead of [onRefresh] when you need to dispose anything
  void refreshPage() {}

  void onRefresh() {
    storage.delete(storageName);
    dataList.clear();
    page = 1;
    pagingController.refresh();
    refreshPage();
  }

  void _initListener(void Function() onLoad) {
    pagingController.addPageRequestListener((page) => onLoad());
  }

  void loadData(Function() onLoad) {
    _initListener(onLoad);
  }

  void showError(String message) {
    pagingController.error = message;
  }

  /// **NOTE:**
  /// make sure you call this method at initial state, before you call method [saveCacheAndFinish]
  Future<void> getCache(Function() onLoad) async {
    if (page == 1) _getCacheData();
    _initListener(onLoad);
  }

  void _getCacheData() {
    var cache = storage.get(storageName);
    if (storage.has(storageName) && cache.toString().isNotEmpty) {
      finishLoadData(
        data: List<T>.from(
          (json.decode(cache) as List).map(
            (x) => CacheModelConverter<T>().fromJson(x),
          ),
        ),
      );
    }
  }

  /// **NOTE:**
  /// call this to finish the load data,
  /// don't need to call [finishLoadData] anymore
  void saveCacheAndFinish({List<T>? data}) async {
    try {
      if (page == 1) await storage.save(storageName, json.encode(data ?? []));
      finishLoadData(data: data ?? []);
    } catch (e) {
      debugPrint('Failed save cache, $e');
      showError(e.toString());
    }
  }

  /// **NOTE:**
  /// call this [finishLoadData] instead [saveCacheAndFinish] if the data is not require to saved in local data
  void finishLoadData({required List<T> data, int? page}) {
    final isLastPage = data.length < perPage;
    if (isLastPage) {
      pagingController.appendLastPage(data);
    } else {
      pagingController.appendPage(data, page ?? this.page++);
    }
    dataList.value = pagingController.itemList ?? [];
  }

  /// **NOTE:**
  /// call this [closePage] instead of [onClose] when you need to dispose anything
  void closePage() {}

  @override
  void onClose() {
    pagingController.dispose();
    closePage();
    super.onClose();
  }
}
