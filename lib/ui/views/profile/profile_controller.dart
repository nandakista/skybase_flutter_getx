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
    loadData(() => onGetProfile());
    super.onReady();
  }

  @override
  Future<void> onRefresh() async {
    super.onRefresh();
    await onGetProfile();
    await Get.find<ProfileRepositoryController>().onRefresh();
  }

  Future<void> onGetProfile() async {
    try {
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
