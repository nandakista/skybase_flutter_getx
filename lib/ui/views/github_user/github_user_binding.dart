import 'package:get/get.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository_impl.dart';
import 'package:skybase/data/sources/server/sample_feature/sample_feature_sources_impl.dart';
import 'package:skybase/ui/views/github_user/github_user_controller.dart';

class GithubUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => GithubUserController(
        repository: SampleFeatureRepositoryImpl(
          apiService: SampleFeatureSourcesImpl(),
        ),
      ),
    );
  }
}
