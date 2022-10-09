import 'dart:developer';

import 'package:get/get.dart';
import 'package:skybase/core/base/pagination_controller.dart';
import 'package:skybase/domain/entities/sample_feature/sample_feature.dart';
import 'package:skybase/domain/usecases/get_user.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_view.dart';

class SampleFeatureListController extends PaginationController<SampleFeature> {
  final GetUsers getUsers;
  SampleFeatureListController({required this.getUsers});

  @override
  void getListData() async {
    try {
      await getUsers(page: page, perPage: perPage).then((data) {
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
