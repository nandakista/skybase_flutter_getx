import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/base/base_controller.dart';
import 'package:skybase/data/sources/local/cached_key.dart';
import 'package:skybase/domain/entities/sample_feature/sample_feature.dart';
import 'package:skybase/domain/usecases/get_detail_user.dart';

class SampleFeatureDetailController extends BaseController<SampleFeature> {
  final GetDetailUser getDetailUser;

  SampleFeatureDetailController({required this.getDetailUser});

  final GlobalKey headerKey = GlobalKey();
  final GlobalKey detailInfoKey = GlobalKey();
  final headerWidget = Rxn<Size>();
  final detailInfoWidget = Rxn<Size>();

  late int idArgs;
  late String usernameArgs;

  @override
  void onInit() {
    super.onInit();
    idArgs = Get.arguments['id'];
    usernameArgs = Get.arguments['username'];
  }

  @override
  void onReady() async {
    getCache(() => onGetDetailUser());

    // Only fetch data
    // loadData(() => onGetDetailUser());
  }

  @override
  void onRefresh() {
    onGetDetailUser();
    super.onRefresh();
  }

  @override
  String get cachedId => idArgs.toString();

  @override
  // Only save last cache
  String get cachedKey => CachedKey.SAMPLE_FEATURE_DETAIL;

  // Save every detail cache
  // String get storageName => CachedKey.SAMPLE_FEATURE_DETAIL + cacheId;

  Future<void> onGetDetailUser() async {
    showLoading();
    try {
      final response = await getDetailUser(
        id: idArgs,
        username: usernameArgs,
      );
      saveCacheAndFinish(data: response);

      // Only fetch data
      // finishLoadData(data: response);
      dismissLoading();
    } catch (e) {
      dismissLoading();
      showError(e.toString());
    }
  }
}
