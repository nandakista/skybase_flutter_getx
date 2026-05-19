import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:skybase/config/base/pagination_controller.dart';
import 'package:skybase/config/base/request_param.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_view.dart';

class GithubUserController extends PaginationController<SampleFeature> {
  final SampleFeatureRepository repository;

  GithubUserController({required this.repository});

  ScrollController scrollController = ScrollController();
  String? searchQuery;

  @override
  void onInit() {
    super.onInit();
    getUsers();
  }

  @override
  Future<void> onRefresh() async {
    resetState();
    await getUsers();
  }

  @override
  bool get keepAlive => false;

  @override
  void onLoadMore() {
    getUsers(page: page + 1);
  }

  Future<void> getUsers({int page = 1}) async {
    try {
      showLoading();
      final response = await repository.getUsers(
        requestParams: RequestParams(cancelToken: cancelToken),
        page: page,
        perPage: perPage,
        username: searchQuery,
      );
      loadSuccess(response, page: page);
    } catch (e) {
      debugPrint('Error : $e');
      loadError(e.toString());
    }
  }

  void onChooseUser({required int id, required String username}) {
    Get.toNamed(
      SampleFeatureDetailView.route,
      arguments: {
        'id': id,
        'username': username,
      },
    );
  }

  void onUpdateSearch({required String? search}) async {
    try {
      searchQuery = search;
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      await onRefresh();
    } catch (e) {
      debugPrint('Error : $e');
      loadError(e.toString());
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
