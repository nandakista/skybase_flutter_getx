import 'package:get/get.dart';
import 'package:skybase/config/base/base_controller.dart';
import 'package:skybase/domain/entities/user/user.dart';
import 'package:skybase/domain/usecases/get_profile.dart';
import 'package:skybase/ui/views/profile/component/repository/profile_repository_controller.dart';

class ProfileController extends BaseController<User> {
  final GetProfile getProfile;

  ProfileController({required this.getProfile});

  @override
  void onReady() {
    loadData(() => onGetProfile());
    super.onReady();
  }

  @override
  Future<void> onRefresh() async {
    await Get.find<ProfileRepositoryController>().onRefresh();
    super.onRefresh();
  }

  @override
  bool get keepAlive => false;

  Future<void> onGetProfile() async {
    try {
      final response = await getProfile(
        requestParams: requestParams,
        username: 'nandakista',
      );
      loadFinish(data: response);
    } catch (e) {
      loadError(e.toString());
    }
  }
}
