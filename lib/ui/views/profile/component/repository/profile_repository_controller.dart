import 'package:skybase/config/base/base_controller.dart';
import 'package:skybase/data/models/repo/repo.dart';
import 'package:skybase/data/repositories/auth/auth_repository.dart';

class ProfileRepositoryController extends BaseController<Repo> {
  final AuthRepository repository;

  ProfileRepositoryController({required this.repository});

  @override
  void onReady() {
    loadData(() => getRepository());
    super.onReady();
  }

  Future<void> getRepository() async {
    try {
      final response = await repository.getProfileRepository(
        requestParams: requestParams,
        username: 'nandakista',
      );
      loadFinish(list: response);
    } catch (e) {
      loadError(e.toString());
    }
  }
}
