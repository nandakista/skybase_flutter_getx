import 'package:get/get.dart';
import 'package:skybase/config/base/base_controller.dart';
import 'package:skybase/data/models/user/user.dart';
import 'package:skybase/data/repositories/auth/auth_repository.dart';
import 'package:skybase/ui/views/profile/component/repository/profile_repository_controller.dart';

class ProfileController extends BaseController<User> {
  final AuthRepository repository;

  ProfileController({required this.repository});

  @override
  void onReady() {
    onGetProfile();
    super.onReady();
  }

  @override
  bool get keepAlive => true;

  @override
  Future<void> onRefresh() async {
    resetState();
    await Future.wait([
      Get.find<ProfileRepositoryController>().onRefresh(),
      onGetProfile(),
    ]);
  }

  Future<void> onGetProfile() async {
    try {
      showLoading();
      final response = await repository.getProfile(
        requestParams: requestParams,
        username: 'nandakista',
      );
      loadFinish(data: response);
    } catch (e) {
      loadError(e.toString());
    }
  }
}
