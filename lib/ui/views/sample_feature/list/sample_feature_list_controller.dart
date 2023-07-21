import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:skybase/core/base/pagination_controller.dart';
import 'package:skybase/core/database/get_storage/get_storage_key.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_view.dart';

class SampleFeatureListController extends PaginationController<SampleFeature> {
  final SampleFeatureRepository repository;

  SampleFeatureListController({required this.repository});

  @override
  void onInitData() {
    getCache().then((_) => getListData());
  }

  @override
  String get storageName => GetStorageKey.sampleFeature;

  void getListData() async {
    try {
      final response = await repository.getUsers(
        page: page,
        perPage: perPage,
      );
      saveCache(list: response);
      loadNextData(data: response);
    } catch (e) {
      debugPrint('Error : $e');
      pagingController.error = e;
    }
  }

  void onChooseUser({required SampleFeature user}) {
    Get.toNamed(SampleFeatureDetailView.route, arguments: user);
  }
}
