import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/base/base_controller.dart';
import 'package:skybase/domain/entities/sample_feature/sample_feature.dart';
import 'package:skybase/domain/usecases/get_detail_user.dart';

class SampleFeatureDetailController extends BaseController {
  final GetDetailUser getDetailUser;
  SampleFeatureDetailController({required this.getDetailUser});

  final GlobalKey headerKey = GlobalKey();
  final GlobalKey detailInfoKey = GlobalKey();
  final headerWidget = Rxn<Size>();
  final detailInfoWidget = Rxn<Size>();

  final user = Rxn<SampleFeature>();

  @override
  void onInit() {
    super.onInit();
    user.value = Get.arguments;
  }

  @override
  void onRefresh() {
    loadData();
  }

  @override
  void onReady() async {
    headerWidget.value = (headerKey.currentContext?.findRenderObject() as RenderBox).size;
    detailInfoWidget.value = (detailInfoKey.currentContext?.findRenderObject() as RenderBox).size;
    await loadData();
  }

  Future<void> loadData() async {
    showLoading();
    try {
      await getDetailUser(user: user.value!).then((res) {
        hideLoading();
        user.value = res;
      });
    } catch (e) {
      hideLoading();
      showError(e.toString());
    }
  }
}