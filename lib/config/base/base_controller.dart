import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:skybase/core/database/get_storage/get_storage_manager.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
abstract class BaseController<T> extends GetxController {
  GetStorageManager storage = GetStorageManager.find;

  CancelToken cancelToken = CancelToken();
  RxBool loadingStatus = false.obs;
  RxString errorMessage = ''.obs;

  int perPage = 20;
  int page = 1;

  final dataObj = Rxn<T>();
  RxList<T> dataList = RxList<T>([]);

  bool get isLoading => loadingStatus.isTrue;

  bool get isError => errorMessage.value.isNotEmpty;

  bool get isEmpty => dataList.isEmpty && dataObj.value == null;

  bool get isSuccess => !isEmpty && !isError && !isLoading;

  void onRefresh() {}

  void showLoading() {
    loadingStatus.value = true;
    errorMessage.value = '';
  }

  void dismissLoading() => loadingStatus.value = false;

  void showError(String message) {
    errorMessage.value = message;
    dismissLoading();
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
  }

  @override
  void onClose() {
    cancelToken.cancel();
    super.onClose();
  }
}
