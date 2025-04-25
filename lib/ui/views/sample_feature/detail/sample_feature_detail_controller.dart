import 'package:get/get.dart';
import 'package:skybase/config/base/base_controller.dart';
import 'package:skybase/data/sources/local/cached_key.dart';
import 'package:skybase/domain/entities/sample_feature/sample_feature.dart';
import 'package:skybase/domain/usecases/get_detail_user.dart';

class SampleFeatureDetailController extends BaseController<SampleFeature> {
  final GetDetailUser getDetailUser;

  SampleFeatureDetailController({required this.getDetailUser});

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
    loadData(() => onGetDetailUser());
    super.onReady();
  }

  @override
  bool get keepAlive => false;

  @override
  String get cachedKey => CachedKey.SAMPLE_FEATURE_DETAIL;

  @override
  String get cachedId => idArgs.toString();

  Future<void> onGetDetailUser() async {
    try {
      final response = await getDetailUser(
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
