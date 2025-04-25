import 'package:skybase/config/base/request_param.dart';
import 'package:skybase/domain/entities/user/user.dart';
import 'package:skybase/domain/repositories/auth_repository.dart';

class GetProfile {
  final AuthRepository repository;

  GetProfile({required this.repository});

  Future<User> call({
    required String username,
    required RequestParams requestParams,
  }) async {
    return await repository.getProfile(
      username: username,
      requestParams: requestParams,
    );
  }
}
