import 'package:skybase/config/base/base_controller.dart';
import 'package:skybase/data/models/repo/repo.dart';
import 'package:skybase/data/repositories/auth/auth_repository.dart';

class ProfileRepositoryController extends BaseController<Repo> {
  final AuthRepository repository;

  ProfileRepositoryController({required this.repository});

  @override
  void onInit() {
    loadData(() => getRepository());
    super.onInit();
  }

  @override
  void onRefresh() {
    getRepository();
  }

  void getRepository() async {
    showLoading();
    try {
      final response = await repository.getProfileRepository(
        cancelToken: cancelToken,
        username: 'nandakista',
      );
      finishLoadData(list: response);
    } catch (e) {
      showError(e.toString());
    }
  }
}
