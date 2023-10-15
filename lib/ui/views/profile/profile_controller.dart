import 'package:get/get.dart';
import 'package:skybase/config/base/base_controller.dart';
import 'package:skybase/data/models/user/user.dart';
import 'package:skybase/data/repositories/auth/auth_repository.dart';
import 'package:skybase/ui/views/profile/component/repository/profile_repository_controller.dart';

class ProfileController extends BaseController<User> {
  final AuthRepository repository;

  ProfileController({required this.repository});

  @override
  void onInit() {
    loadData(() => onGetProfile());
    super.onInit();
  }

  @override
  void onRefresh() {
    onGetProfile();
    Get.find<ProfileRepositoryController>().onRefresh();
  }

  void onGetProfile() async {
    showLoading();
    try {
      final response = await repository.getProfile(
        cancelToken: cancelToken,
        username: 'nandakista',
      );
      finishLoadData(data: response);
    } catch (e) {
      showError(e.toString());
    }
  }
}
