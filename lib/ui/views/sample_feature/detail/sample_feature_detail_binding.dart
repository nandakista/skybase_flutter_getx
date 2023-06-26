import 'package:get/get.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository_impl.dart';
import 'package:skybase/data/sources/local/sample_feature/sample_feature_dao_impl.dart';
import 'package:skybase/data/sources/server/sample_feature/sample_feature_api_impl.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_controller.dart';

class SampleFeatureDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SampleFeatureDetailController(
        repository: SampleFeatureRepositoryImpl(
          apiService: SampleFeatureApiImpl(),
          dao: SampleFeatureDaoImpl(),
        ),
      ),
    );
  }
}
