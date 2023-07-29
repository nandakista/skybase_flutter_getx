import 'package:skybase/core/base/base_controller.dart';
import 'package:skybase/data/sources/local/cached_key.dart';
import 'package:skybase/domain/entities/repo/repo.dart';
import 'package:skybase/domain/usecases/get_profile_repository.dart';

class ProfileRepositoryController extends BaseController<Repo> {
  final GetProfileRepository getProfileRepository;

  ProfileRepositoryController({required this.getProfileRepository});

  @override
  void onInit() {
    getCache(() => onGetProfileRepository());
    super.onInit();
  }

  @override
  void onRefresh() {
    onGetProfileRepository();
    super.onRefresh();
  }

  @override
  String get cachedId => throw UnimplementedError();

  @override
  String get cachedKey => CachedKey.USER_REPOSITORY;

  void onGetProfileRepository() async {
    showLoading();
    try {
      final response = await getProfileRepository(username: 'nandakista');
      saveCacheAndFinish(list: response);
      dismissLoading();
    } catch (e) {
      dismissLoading();
      showError(e.toString());
    }
  }

}