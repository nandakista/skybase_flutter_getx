import 'package:skybase/domain/entities/user/user.dart';
import 'package:skybase/domain/repositories/auth_repository.dart';

class VerifyToken {
  AuthRepository repository;

  VerifyToken({required this.repository});

  Future<User?> call({
    required int userId,
    required String token,
  }) async {
    return await repository.verifyToken(
      userId: userId,
      token: token,
    );
  }
}