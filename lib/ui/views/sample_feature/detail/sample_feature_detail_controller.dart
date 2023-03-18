import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/base/base_controller.dart';
import 'package:skybase/core/helper/dialog_helper.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository.dart';

class SampleFeatureDetailController extends BaseController {
  final SampleFeatureRepository repository;
  SampleFeatureDetailController({required this.repository});

  final user = Rxn<SampleFeature>();

  @override
  void onInit() {
    super.onInit();
    user.value = Get.arguments;
  }

  @override
  void onReady() async {
    await getDetailUser();
  }

  @override
  void onRefresh() {
    getDetailUser();
  }

  getDetailUser() async {
    showLoading();
    try {
      await repository.getDetailUser(user: user.value!).then((res) {
        hideLoading();
        user.value = res;
      });
    } catch (e) {
      hideLoading();
      showError(e.toString());
    }
  }
}