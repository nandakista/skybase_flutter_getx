import 'package:skybase/domain/entities/user/user.dart';

abstract class AuthApi {
  Future<User> verifyToken({
    required int userId,
    required String token,
  });

  Future<User> login({
    required String phoneNumber,
    required String email,
    required String password,
  });
}
