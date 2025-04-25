import 'package:skybase/config/base/request_param.dart';
import 'package:skybase/domain/entities/repo/repo.dart';
import 'package:skybase/domain/repositories/auth_repository.dart';

class GetProfileRepository {
  final AuthRepository repository;

  GetProfileRepository({required this.repository});

  Future<List<Repo>> call({
    required String username,
    required RequestParams requestParams,
  }) async {
    return await repository.getProfileRepository(
      username: username,
      requestParams: requestParams,
    );
  }
}
