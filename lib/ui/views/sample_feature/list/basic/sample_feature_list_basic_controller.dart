import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:skybase/config/base/pagination_controller.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_view.dart';

class SampleFeatureListBasicController extends GetxController {
  final SampleFeatureRepository repository;

  SampleFeatureListBasicController({required this.repository});

  RxList<SampleFeature> datas = <SampleFeature>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void onRefresh() {
    getUsers();
  }

  void getUsers() async {
    try {
      isLoading.value = true;
      final response = await repository.getUsers(
        cancelToken: CancelToken(),
        page: 1,
        perPage: 15,
      );
      isLoading.value = false;
      datas.value = response;
    } catch (e) {
      isLoading.value = false;
      debugPrint('Error : $e');
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
