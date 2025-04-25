import 'package:skybase/config/base/request_param.dart';
import 'package:skybase/domain/entities/repo/repo.dart';
import 'package:skybase/domain/entities/user/user.dart';

abstract class AuthRepository {
  Future<User> verifyToken({
    required int userId,
    required String token,
  });

  Future<User> login({
    required String phoneNumber,
    required String email,
    required String password,
  });

  Future<User> getProfile({
    required String username,
    required RequestParams requestParams,
  });

  Future<List<Repo>> getProfileRepository({
    required String username,
    required RequestParams requestParams,
  });
}
