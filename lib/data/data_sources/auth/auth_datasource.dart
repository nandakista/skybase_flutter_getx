import 'package:varcore_flutter_base/data/models/user.dart';

abstract class AuthDatasource {
  Future<User> verifyToken({
    required int userId,
    required String token,
  });

  Future<User> login({
    required String phoneNumber,
    required String email,
    required String password,
  });

  Future<List<User>> getUsers({
    int page = 1,
    int perPage = 20,
  });
}
