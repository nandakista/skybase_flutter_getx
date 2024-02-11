/* Created by
   Varcant
   nanda.kista@gmail.com
*/

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:skybase/config/base/request_state.dart';
import 'package:skybase/core/mixin/cache_mixin.dart';
import 'package:skybase/core/mixin/connectivity_mixin.dart';

abstract class BaseController<T> extends GetxController
    with ConnectivityMixin, CacheMixin {
  CancelToken cancelToken = CancelToken();
  final errorMessage = Rxn<String>();

  Rx<RequestState> state = RequestState.initial.obs;

  int perPage = 20;
  int page = 1;

  final dataObj = Rxn<T>();
  RxList<T> dataList = RxList<T>([]);

  Future Function()? _onLoad;

  bool get keepAlive => false;

  String get cachedKey => '';

  bool get isInitial => state.value.isInitial;

  bool get isLoading => state.value.isLoading;

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
    if (_onLoad != null) {
      if (cachedKey.isNotEmpty) {
        await deleteCached(cachedKey);
      }
      if (!keepAlive) showLoading();
      await _onLoad!();
    }
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
    this._onLoad = onLoad;
  }

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
