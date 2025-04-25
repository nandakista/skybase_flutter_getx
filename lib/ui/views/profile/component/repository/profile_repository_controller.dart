import 'package:skybase/config/base/base_controller.dart';
import 'package:skybase/domain/entities/repo/repo.dart';
import 'package:skybase/domain/usecases/get_profile_repository.dart';

class ProfileRepositoryController extends BaseController<Repo> {
  final GetProfileRepository getProfileRepository;

  ProfileRepositoryController({required this.getProfileRepository});

  @override
  void onReady() {
    loadData(() => getRepository());
    super.onReady();
  }

  @override
  bool get keepAlive => false;

  Future<void> getRepository() async {
    try {
      final response = await getProfileRepository(
        requestParams: requestParams,
        username: 'nandakista',
      );
      loadFinish(list: response);
    } catch (e) {
      loadError(e.toString());
    }
  }
}
