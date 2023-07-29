import 'package:get/get.dart';
import 'package:skybase/data/repositories/auth_repository_impl.dart';
import 'package:skybase/data/sources/server/auth/auth_sources_impl.dart';
import 'package:skybase/domain/usecases/get_profile.dart';
import 'package:skybase/domain/usecases/get_profile_repository.dart';
import 'package:skybase/ui/views/profile/component/repository/profile_repository_controller.dart';
import 'package:skybase/ui/views/profile/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ProfileController(
        getProfile: GetProfile(
          repository: AuthRepositoryImpl(apiService: AuthSourcesImpl()),
        ),
      ),
    );

    Get.lazyPut(
      () => ProfileRepositoryController(
        getProfileRepository: GetProfileRepository(
          repository: AuthRepositoryImpl(apiService: AuthSourcesImpl()),
        ),
      ),
    );
  }
}
