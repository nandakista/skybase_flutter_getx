/* Created by
   Varcant
   nanda.kista@gmail.com
*/

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:skybase/config/base/connectivity_mixin.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';

enum RequestState { initial, empty, loading, success, error, shimmering }

extension RequestStateExt on RequestState {
  bool get isInitial => this == RequestState.initial;

  bool get isEmpty => this == RequestState.empty;

  bool get isLoading => this == RequestState.loading;

  bool get isSuccess => this == RequestState.success;

  bool get isError => this == RequestState.error;

  bool get isShimmering => this == RequestState.shimmering;
}

abstract class BaseController<T> extends GetxController with ConnectivityMixin {
  StorageManager storage = StorageManager.find;

  CancelToken cancelToken = CancelToken();
  final errorMessage = Rxn<String>();

  Rx<RequestState> state = RequestState.initial.obs;

  int perPage = 20;
  int page = 1;

  final dataObj = Rxn<T>();
  RxList<T> dataList = RxList<T>([]);

  bool get keepAlive => false;

  String get cacheKey => '';

  bool get isInitial => state.value.isInitial;

  bool get isLoading => state.value.isLoading;

  bool get isShimmering => isLoading && !isEmpty;

  bool get isError =>
      errorMessage.value != null &&
      errorMessage.value != '' &&
      state.value.isError;

  bool get isEmpty => state.value.isEmpty;

  bool get isSuccess =>
      !isEmpty && !isError && !isLoading && state.value.isSuccess;

  @mustCallSuper
  @override
  onInit() {
    listenConnectivity(() {
      if (isError && !isLoading) onRefresh();
    });
    super.onInit();
  }

  Future<void> onRefresh() async {
    if (cacheKey.isNotEmpty) {
      await storage.delete(cacheKey);
    }
    if (!keepAlive) showLoading();
  }

  @mustCallSuper
  @override
  void onClose() {
    cancelConnectivity();
    cancelToken.cancel();
    super.onClose();
  }

  void showLoading() {
    state.value = RequestState.loading;
    errorMessage.value = null;
  }

  void loadError(String message) {
    errorMessage.value = message;
    state.value = RequestState.error;
  }

  void loadData(Future Function() onLoad) async {
    showLoading();
    await onLoad();
  }

  /// **NOTE:**
  /// call this [loadFinish] instead [saveCacheAndFinish] if the data
  /// is not require to saved in local data
  loadFinish({
    T? data,
    List<T> list = const [],
  }) {
    if (data != null) dataObj.value = data;
    if (list.isNotEmpty) dataList.value = list;
    if (dataList.isEmpty && dataObj.value == null) {
      state.value = RequestState.empty;
    } else {
      state.value = RequestState.success;
    }
  }
}
