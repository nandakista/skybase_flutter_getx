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
  bool get keepAlive => false;

  @override
  String get cachedKey => '${CachedKey.SAMPLE_FEATURE_DETAIL}/$idArgs';

  Future<void> getDetailUser() async {
    try {
      final response = await repository.getDetailUser(
        cancelToken: cancelToken,
        id: idArgs,
        username: usernameArgs,
      );
      loadFinish(data: response);
    } catch (e) {
      loadError(e.toString());
    }
  }
}
