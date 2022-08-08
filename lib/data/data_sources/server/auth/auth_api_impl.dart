import 'dart:developer';

import 'package:skybase/core/network/api_request.dart';
import 'package:skybase/core/network/api_response.dart';
import 'package:skybase/core/network/api_url.dart';
import 'package:skybase/data/models/user/user.dart';

import 'auth_api.dart';

class AuthApiImpl implements AuthApi {
  String tag = 'Auth Api';

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
      return User.fromJson(ApiResponse.fromJson(response.data).data);
    } catch (e) {
      log('$tag Error = $e');
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
      return User.fromJson(ApiResponse.fromJson(response.data).data);
    } catch (e) {
      log('$tag Error = $e');
      rethrow;
    }
  }
}
