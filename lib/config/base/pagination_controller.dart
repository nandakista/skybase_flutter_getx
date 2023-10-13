import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skybase/core/database/get_storage/get_storage_manager.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
abstract class PaginationController<T> extends GetxController {
  GetStorageManager storage = GetStorageManager.find;

  CancelToken cancelToken = CancelToken();
  int perPage = 20;
  int page = 1;
  final pagingController = PagingController<int, T>(firstPageKey: 0);

  @mustCallSuper
  void onRefresh() {
    page = 1;
    pagingController.refresh();
  }

  void loadData(Function() onLoad) {
    pagingController.addPageRequestListener((page) => onLoad());
  }

  void showError(String message) {
    pagingController.error = message;
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
    cancelToken.cancel();
    super.onClose();
  }
}
