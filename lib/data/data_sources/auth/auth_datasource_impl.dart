import 'package:varcore_flutter_base/core/network/api_request.dart';
import 'package:varcore_flutter_base/core/network/api_url.dart';
import 'package:varcore_flutter_base/data/models/user.dart';

import 'auth_datasource.dart';

class AuthDatasourceImpl implements AuthDatasource {

  @override
  Future<User> login({
    required String phoneNumber,
    required String email,
    required String password,
  }) async {
    try {
      final response = await sendRequest(
        url: ApiUrl.login,
        requestMethod: RequestMethod.POST,
        body: {
          'phone': phoneNumber,
          'password': password,
          'email': email,
        },
      );
      return User.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<User> verifyToken({
    required int userId,
    required String token,
  }) async {
    try {
      final response = await sendRequest(
        url: ApiUrl.verifyToken,
        requestMethod: RequestMethod.POST,
        useToken: true,
        body: {
          'uid': userId,
          'token': token,
        },
      );
      return User.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }
}
