import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:skybase/config/base/pagination_controller.dart';
import 'package:skybase/data/sources/local/cached_key.dart';
import 'package:skybase/domain/entities/sample_feature/sample_feature.dart';
import 'package:skybase/domain/usecases/get_users.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_view.dart';

class SampleFeatureListController extends PaginationController<SampleFeature> {
  final GetUsers getUsers;

  SampleFeatureListController({required this.getUsers});

  @override
  void onReady() {
    loadData(() => onGetUsers());
    super.onReady();
  }

  @override
  bool get keepAlive => true;

  @override
  String get cachedKey => CachedKey.SAMPLE_FEATURE_LIST;

  Future<void> onGetUsers() async {
    try {
      final response = await getUsers(
        requestParams: requestParams,
        page: page,
        perPage: perPage,
      );
      loadNextData(data: response);
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
}
