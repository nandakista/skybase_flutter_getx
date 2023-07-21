import 'dart:convert';

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
  bool isRefresh = false;

  String get storageName;

  void onInitData();

  @override
  void onInit() {
    pagingController.addPageRequestListener((page) {
      onInitData();
    });
    super.onInit();
  }

  void onRefresh() {
    storage.delete(storageName);
    page = 1;
    isRefresh = true;
    pagingController.refresh();
  }

  void loadNextData({required List<T> data, int? page}) {
    final isLastPage = data.length < perPage;
    if (isLastPage) {
      pagingController.appendLastPage(data);
    } else {
      final nextPage = page ?? this.page++;
      pagingController.appendPage(data, nextPage);
    }
  }

  /// **NOTE:**
  /// make sure you call this method at initial state, before you call method [saveCache]
  Future<void> getCache({String id = '0'}) async {
    var cache = storage.get(storageName);
    if (storage.has(storageName)) {
      if (cache != null && cache.toString().isNotEmpty) {
        loadNextData(
          data: List<T>.from(
            (json.decode(cache) as List).map(
              (x) => CacheModelConverter<T>().fromJson(x),
            ),
          ),
          page: 1,
        );
      }
    }
  }

  Future<void> saveCache({
    List<T>? list,
    T? data,
  }) async {
    try {
      await storage.save(storageName, json.encode(list ?? []));
    } catch (e) {
      pagingController.error = e;
    }
  }
}
