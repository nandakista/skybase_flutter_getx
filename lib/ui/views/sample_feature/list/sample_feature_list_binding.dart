import 'package:get/get.dart';
import 'package:skybase/data/sources/local/sample_feature/sample_feature_dao_impl.dart';
import 'package:skybase/data/sources/server/sample_feature/sample_feature_sources_impl.dart';
import 'package:skybase/data/repositories/sample_feature_repository_impl.dart';
import 'package:skybase/domain/usecases/get_user.dart';
import 'package:skybase/ui/views/sample_feature/list/sample_feature_list_controller.dart';

class SampleFeatureListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SampleFeatureListController(
        getUsers: GetUsers(
          repository: SampleFeatureRepositoryImpl(
            apiService: SampleFeatureSourcesImpl(),
            dao: SampleFeatureDaoImpl(),
          ),
        ),
      ),
    );
  }
}
