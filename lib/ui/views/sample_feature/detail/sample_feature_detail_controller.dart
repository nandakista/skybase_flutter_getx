import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/base/base_controller.dart';
import 'package:skybase/core/database/get_storage/get_storage_key.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository.dart';

class SampleFeatureDetailController extends BaseController<SampleFeature> {
  final SampleFeatureRepository repository;

  SampleFeatureDetailController({required this.repository});

  final GlobalKey headerKey = GlobalKey();
  final GlobalKey detailInfoKey = GlobalKey();
  final headerWidget = Rxn<Size>();
  final detailInfoWidget = Rxn<Size>();

  late int idArgs;
  late String usernameArgs;

  final user = Rxn<SampleFeature>();

  @override
  void onInit() {
    super.onInit();
    idArgs = Get.arguments['id'];
    usernameArgs = Get.arguments['username'];
  }

  @override
  void onReady() async {
    _initScreenPref();
    user.value = await getCache(() => getDetailUser());

    // Only fetch data
    // loadData(() => getDetailUser());
  }

  @override
  void refreshData() {
    getDetailUser();
  }

  @override
  String get cacheId => idArgs.toString();

  @override
  String get storageName => GetStorageKey.SAMPLE_FEATURE_DETAIL;

  Future<void> getDetailUser() async {
    showLoading();
    try {
      final response = await repository.getDetailUser(
        id: idArgs,
        username: usernameArgs,
      );
      saveCache(data: response);
      user.value = response;
      hideLoading();
    } catch (e) {
      hideLoading();
      showError(e.toString());
    }
  }

  void _initScreenPref() {
    headerWidget.value = (headerKey.currentContext?.findRenderObject() as RenderBox).size;
    detailInfoWidget.value = (detailInfoKey.currentContext?.findRenderObject() as RenderBox).size;
  }
}
