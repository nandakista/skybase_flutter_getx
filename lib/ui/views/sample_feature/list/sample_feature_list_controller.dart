import 'dart:developer';

import 'package:get/get.dart';
import 'package:skybase/core/base/pagination_controller.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_view.dart';

class SampleFeatureListController extends PaginationController<SampleFeature> {
  final SampleFeatureRepository repository;
  SampleFeatureListController({required this.repository});

  @override
  void getListData() async {
    try {
      await repository
          .getUsers(page: page, perPage: perPage, isRefresh: isRefresh)
          .then((data) {
        loadNextData(data);
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
