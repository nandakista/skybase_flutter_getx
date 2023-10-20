import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
enum RequestState { initial, empty, loading, success, error, shimmering }

extension RequestStateExt on RequestState {
  bool get isInitial => this == RequestState.initial;

  bool get isEmpty => this == RequestState.empty;

  bool get isLoading => this == RequestState.loading;

  bool get isSuccess => this == RequestState.success;

  bool get isError => this == RequestState.error;

  bool get isShimmering => this == RequestState.shimmering;
}

abstract class BaseController<T> extends GetxController {
  StorageManager storage = StorageManager.find;

  CancelToken cancelToken = CancelToken();
  RxString errorMessage = ''.obs;

  Rx<RequestState> state = RequestState.initial.obs;

  int perPage = 20;
  int page = 1;

  final dataObj = Rxn<T>();
  RxList<T> dataList = RxList<T>([]);

  bool get isInitial => state.value.isInitial;

  bool get isLoading => state.value.isLoading;

  bool get isShimmering => isLoading && !isEmpty;

  bool get isError => errorMessage.value.isNotEmpty && state.value.isError;

  bool get isEmpty => state.value.isEmpty;

  bool get isSuccess => !isEmpty && !isError && !isLoading && state.value.isSuccess;

  Future<void> deleteCached(String cacheKey, {String? cacheId}) async {
    if (cacheId != null) {
      await storage.delete('$cacheKey/$cacheId');
    } else {
      await storage.delete(cacheKey.toString());
    }
  }

  void onRefresh() {}

  void showLoading() {
    state.value = RequestState.loading;
    errorMessage.value = '';
  }

  void showError(String message) {
    errorMessage.value = message;
    state.value = RequestState.error;
  }

  void loadData(Function() onLoad) {
    onLoad();
  }

  /// **NOTE:**
  /// call this [finishLoadData] instead [saveCacheAndFinish] if the data
  /// is not require to saved in local data
  finishLoadData({
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

  @override
  void onClose() {
    cancelToken.cancel();
    super.onClose();
  }
}
