import 'dart:developer';

import 'package:get/get.dart';
import 'package:skybase/core/base/pagination_cache_controller.dart';
import 'package:skybase/core/base/pagination_controller.dart';
import 'package:skybase/core/database/hive/hive_box.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_view.dart';

class SampleFeatureListCacheController
    extends PaginationCacheController<SampleFeature> {
  final SampleFeatureRepository repository;
  SampleFeatureListCacheController({required this.repository});

  @override
  void onInit() {
    openBox(HiveBox.user);
    super.onInit();
  }

  @override
  getListData() async {
    try {
      await repository.getUserss(page: page, perPage: perPage).then((data) {
        saveCache(
          data: data,
          idList: data.map(
            (e) => e.id.toString(),
          ),
        );
        loadNextData(data);
        return data;
      });
    } catch (e) {
      log('Error : $e');
      pagingController.error = e;
    }
  }

  onChooseUser({required SampleFeature user}) {
    Get.toNamed(SampleFeatureDetailView.route, arguments: user);
  }
}
