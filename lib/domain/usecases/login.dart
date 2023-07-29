import 'package:skybase/domain/entities/user/user.dart';
import 'package:skybase/domain/repositories/auth_repository.dart';

class Login {
  AuthRepository repository;

  Login({required this.repository});

  Future<User?> call({
    required String phoneNumber,
    required String email,
    required String password,
  }) async {
    return await repository.login(
      phoneNumber: phoneNumber,
      email: email,
      password: password,
    );
  }
}