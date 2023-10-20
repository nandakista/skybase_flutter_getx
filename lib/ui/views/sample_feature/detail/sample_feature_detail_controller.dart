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
    loadData(() => getDetailUser());
    super.onReady();
  }

  @override
  void onRefresh() async {
    await deleteCached(
      CachedKey.SAMPLE_FEATURE_DETAIL,
      cacheId: idArgs.toString(),
    );
    await getDetailUser();
  }

  Future<void> getDetailUser() async {
    showLoading();
    try {
      final response = await repository.getDetailUser(
        cancelToken: cancelToken,
        id: idArgs,
        username: usernameArgs,
      );
      finishLoadData(data: response);
    } catch (e) {
      showError(e.toString());
    }
  }
}
