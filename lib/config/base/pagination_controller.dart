import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:skybase/config/base/request_param.dart';
import 'package:skybase/core/mixin/cache_mixin.dart';
import 'package:skybase/core/mixin/connectivity_mixin.dart';
import 'package:skybase/ui/widgets/base/pagination/pagination.dart';

abstract class PaginationController<T> extends GetxController
    with ConnectivityMixin, CacheMixin {
  late RequestParams requestParams;

  RxList<T> dataList = <T>[].obs;

  Rx<PaginationState> state = Rx<PaginationState>(PaginationState.initial);

  final CancelToken cancelToken = CancelToken();
  RxBool allLoaded = false.obs;
  final errorMessage = Rxn<String>();

  int page = 1;
  int perPage = 20;
  bool isPullRefresh = false;

  String get cachedKey => '';

  bool get keepAlive => false;

  @override
  void onInit() {
    requestParams = RequestParams(
      cancelToken: cancelToken,
      cachedKey: cachedKey,
    );
    listenConnectivity(() {
      if (state.value.isError) {
        onRefresh();
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    cancelConnectivity();
    cancelToken.cancel();
    super.onClose();
  }

  void onRefresh();

  void onLoadMore();

  void resetState() async {
    isPullRefresh = true;
    page = 1;
    state.value = PaginationState.initial;
    if (!keepAlive) {
      dataList.clear();
    }
    if (cachedKey.isNotEmpty) await deleteCached(cachedKey);
  }

  void showLoading() {
    state.value = isPullRefresh && keepAlive
        ? PaginationState.success
        : dataList.isEmpty
        ? PaginationState.loading
        : PaginationState.loadingMore;
    allLoaded.value = false;
  }

  void loadSuccess(List<T> response, {int page = 1}) {
    if (page == 1) {
      dataList.clear();
      state.value = response.isEmpty
          ? PaginationState.empty
          : PaginationState.success;
    } else {
      state.value = PaginationState.success;
    }

    isPullRefresh = false;
    dataList.addAll(response);
    this.page = page;

    if (response.length < perPage) {
      allLoaded.value = true;
    }
  }

  void loadError(String error) {
    if (page == 1) {
      state.value = PaginationState.error;
      errorMessage.value = error;
    } else {
      state.value = PaginationState.errorMore;
    }
  }
}
