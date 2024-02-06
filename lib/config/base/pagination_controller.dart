/* Created by
   Varcant
   nanda.kista@gmail.com
*/

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skybase/config/base/cache_mixin.dart';
import 'package:skybase/config/base/connectivity_mixin.dart';

abstract class PaginationController<T> extends GetxController
    with ConnectivityMixin, CacheMixin {
  CancelToken cancelToken = CancelToken();
  int perPage = 20;
  int page = 1;
  final pagingController = PagingController<int, T>(firstPageKey: 1);

  bool get keepAlive => false;

  String get cacheKey;

  @mustCallSuper
  @override
  onInit() {
    listenConnectivity(() {
      if (pagingController.value.status == PagingStatus.firstPageError) {
        onRefresh();
      }
    });
    super.onInit();
  }

  /// ### Note:
  /// Ensure trigger logic after super.onRefresh().
  ///
  /// **Don't put your logic before or above super.onRefresh()**
  @mustCallSuper
  Future<void> onRefresh() async {
    page = 1;
    await deleteCached(cacheKey);
    pagingController.value = PagingState(
      nextPageKey: page,
      error: null,
      itemList: keepAlive ? _keepAliveData : null,
    );
  }

  @mustCallSuper
  @override
  void onClose() {
    cancelConnectivity();
    pagingController.dispose();
    cancelToken.cancel();
    super.onClose();
  }

  void loadData(Future Function() onLoad) async {
    pagingController.addPageRequestListener((page) async {
      if (page > 1) await onLoad();
    });
    if (page == 1) await onLoad();
  }

  void loadError(String message) {
    pagingController.error = message;
  }

  void loadNextData({required List<T> data}) {
    final isLastPage = data.length < perPage;
    if (isLastPage) {
      pagingController.appendLastPage(data);
    } else {
      if (page == 1 && (pagingController.itemList ?? []).isNotEmpty) {
        pagingController.itemList?.clear();
      }
      this.page++;
      pagingController.appendPage(data, page);
    }
  }

  List<T> get _keepAliveData {
    List<T> dataList = pagingController.itemList ?? [];
    if (dataList.length >= perPage) {
      return dataList.sublist(0, perPage);
    } else {
      return dataList;
    }
  }
}
