import 'package:get/get.dart';
import 'package:skybase/config/auth_manager/auth_manager.dart';
import 'package:skybase/core/base/base_controller.dart';
import 'package:skybase/data/sources/local/cached_key.dart';
import 'package:skybase/domain/entities/user/user.dart';
import 'package:skybase/domain/usecases/get_profile.dart';
import 'package:skybase/ui/views/profile/component/repository/profile_repository_controller.dart';

class ProfileController extends BaseController<User> {
  final GetProfile getProfile;

  ProfileController({required this.getProfile});

  @override
  void onInit() {
    getCache(() => onGetProfile());
    super.onInit();
  }

  @override
  String get cachedId => AuthManager.find.user!.id.toString();

  @override
  String get cachedKey => CachedKey.PROFILE;

  @override
  void onRefresh() {
    onGetProfile();
    Get.find<ProfileRepositoryController>().onRefresh();
    super.onRefresh();
  }

  void onGetProfile() async {
    showLoading();
    try {
      final response = await getProfile(username: 'nandakista');
      saveCacheAndFinish(data: response);
      dismissLoading();
    } catch (e) {
      dismissLoading();
      showError(e.toString());
    }
  }
}