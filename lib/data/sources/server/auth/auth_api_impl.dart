import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:skybase/core/app/app_env.dart';
import 'package:skybase/core/database/secure_storage/secure_storage_manager.dart';
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
      final response = await ApiRequest.post(
        url: ApiUrl.login,
        body: {
          'phone': phoneNumber,
          'password': password,
          'email': email,
        },
      );
      return User.fromJson(ApiResponse.fromJson(response.data).data);
    } catch (e) {
      debugPrint('$tag Error = $e');
      rethrow;
    }
  }

  @override
  Future<User> verifyToken({
    required int userId,
    required String token,
  }) async {
    try {
      String? token = await SecureStorageManager.find.getToken();
      String url = AppEnv.config.baseUrl;
      url += ApiUrl.verifyToken;
      final response = await Dio().get(
        url,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
            'Accept': Headers.jsonContentType,
            'Client-Token': AppEnv.config.clientToken,
          },
          contentType: Headers.jsonContentType,
        ),
      );
      return User.fromJson(ApiResponse.fromJson(response.data).data);
    } catch (e) {
      debugPrint('$tag Error = $e');
      rethrow;
    }
  }
}
