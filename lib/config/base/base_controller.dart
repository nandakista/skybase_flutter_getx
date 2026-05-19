/* Created by
   Varcant
   nanda.kista@gmail.com
*/

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:skybase/core/mixin/cache_mixin.dart';
import 'package:skybase/core/mixin/connectivity_mixin.dart';
import 'package:skybase/ui/widgets/base/state/state_view.dart';

import 'request_param.dart';

abstract class BaseController<T> extends GetxController
    with ConnectivityMixin, CacheMixin {
  late RequestParams requestParams;

  CancelToken cancelToken = CancelToken();
  final errorMessage = Rxn<String>();

  Rx<RequestState> state = Rx<RequestState>(RequestState.initial);

  int perPage = 20;
  int page = 1;
  bool isPullRefresh = false;

  final dataObj = Rxn<T>();
  RxList<T> dataList = RxList<T>([]);

  // Future Function()? _onLoad;

  bool get keepAlive => false;

  String get cachedKey => '';

  String get cachedId => '';

  @mustCallSuper
  @override
  onInit() {
    requestParams = RequestParams(
      cancelToken: cancelToken,
      cachedKey: cachedKey,
      cachedId: cachedId,
    );
    listenConnectivity(() {
      if (state.value.isError && !state.value.isLoading) onRefresh();
    });
    super.onInit();
  }

  @mustCallSuper
  @override
  void onClose() {
    cancelConnectivity();
    cancelToken.cancel();
    super.onClose();
  }

  void onRefresh();

  void resetState() async {
    isPullRefresh = true;
    page = 1;
    state.value = RequestState.initial;
    if (!keepAlive) {
      dataList.clear();
      dataObj.value = null;
    }
    if (cachedKey.isNotEmpty) await deleteCached('$cachedKey/$cachedId');
  }

  void showLoading() {
    state.value = isPullRefresh && keepAlive
        ? RequestState.success
        : RequestState.loading;
    errorMessage.value = null;
  }

  void loadError(String message) {
    errorMessage.value = message;
    state.value = RequestState.error;
  }

  void loadFinish({T? data, List<T> list = const []}) {
    if (data != null) dataObj.value = data;
    if (list.isNotEmpty) dataList.value = list;
    if (dataList.isEmpty && dataObj.value == null) {
      state.value = RequestState.empty;
    } else {
      state.value = RequestState.success;
    }
    isPullRefresh = false;
  }
}
