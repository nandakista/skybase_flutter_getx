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

  String get storageName;

  void refreshData() {}

  void onRefresh() {
    storage.delete(storageName);
    page = 1;
    pagingController.refresh();
    refreshData();
  }

  void _initListener(void Function() onLoad) {
    pagingController.addPageRequestListener((page) => onLoad());
  }

  void loadData(Function() onLoad) {
    _initListener(onLoad);
  }

  /// **NOTE:**
  /// make sure you call this method at initial state, before you call method [saveCache]
  Future<void> getCache(Function() onLoad) async {
    if (page == 1) _getCacheData();
    _initListener(onLoad);
  }

  void _getCacheData() {
    var cache = storage.get(storageName);
    if (storage.has(storageName) && cache.toString().isNotEmpty) {
      loadNextData(
        data: List<T>.from(
          (json.decode(cache) as List).map(
            (x) => CacheModelConverter<T>().fromJson(x),
          ),
        ),
      );
    }
  }

  void saveCache({List<T>? data}) async {
    try {
      if (page == 1) await storage.save(storageName, json.encode(data ?? []));
    } catch (e) {
      debugPrint('Failed save cache $e');
      pagingController.error = e;
    }
  }

  void loadNextData({required List<T> data, int? page}) {
    final isLastPage = data.length < perPage;
    if (isLastPage) {
      pagingController.appendLastPage(data);
    } else {
      pagingController.appendPage(data, page ?? this.page++);
    }
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}
