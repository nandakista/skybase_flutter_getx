import 'package:skybase/config/base/request_param.dart';
import 'package:skybase/data/sources/server/auth/auth_sources_impl.dart';
import 'package:skybase/domain/entities/repo/repo.dart';
import 'package:skybase/domain/entities/user/user.dart';

import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthSourcesImpl apiService;

  AuthRepositoryImpl({required this.apiService});

  String tag = 'AuthRepositoryImpl::->';

  @override
  Future<User> login({
    required String phoneNumber,
    required String email,
    required String password,
  }) async {
    return await apiService.login(
      phoneNumber: phoneNumber,
      email: email,
      password: password,
    );
  }

  @override
  Future<User> verifyToken({
    required int userId,
    required String token,
  }) async {
    return await apiService.verifyToken(userId: userId, token: token);
  }

  @override
  Future<User> getProfile({
    required String username,
    required RequestParams requestParams,
  }) async {
    return await apiService.getProfile(
        username: username, cancelToken: requestParams.cancelToken);
  }

  @override
  Future<List<Repo>> getProfileRepository({
    required String username,
    required RequestParams requestParams,
  }) async {
    return await apiService.getProfileRepository(
      username: username,
      cancelToken: requestParams.cancelToken,
    );
  }
}
