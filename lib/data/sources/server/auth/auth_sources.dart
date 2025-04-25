import 'package:dio/dio.dart';
import 'package:skybase/domain/entities/repo/repo.dart';
import 'package:skybase/domain/entities/user/user.dart';

abstract interface class AuthSources {
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
    required CancelToken cancelToken,
    required String username,
  });

  Future<List<Repo>> getProfileRepository({
    required CancelToken cancelToken,
    required String username,
  });
}
