import 'package:get/get.dart';
import 'package:skybase/config/base/base_controller.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository.dart';
import 'package:skybase/data/sources/local/cached_key.dart';

class SampleFeatureDetailController extends BaseController<SampleFeature> {
  final SampleFeatureRepository repository;

  SampleFeatureDetailController({required this.repository});

  late int idArgs;
  late String usernameArgs;

  @override
  void onInit() {
    idArgs = Get.arguments['id'];
    usernameArgs = Get.arguments['username'];
    super.onInit();
  }

  @override
  void onReady() async {
    getDetailUser();
    super.onReady();
  }

  @override
  bool get keepAlive => true;

  @override
  String get cachedKey => CachedKey.SAMPLE_FEATURE_DETAIL;

  @override
  String get cachedId => idArgs.toString();

  @override
  Future<void> onRefresh() async {
    resetState();
    await getDetailUser();
  }

  Future<void> getDetailUser() async {
    try {
      showLoading();
      await Future.delayed(Duration(seconds: 2));
      final response = await repository.getDetailUser(
        requestParams: requestParams,
        id: idArgs,
        username: usernameArgs,
      );
      loadFinish(data: response);
    } catch (e) {
      loadError(e.toString());
    }
  }
}
