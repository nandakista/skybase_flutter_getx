// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:skybase/core/app/app_env.dart';
import 'package:skybase/core/auth_manager/auth_manager.dart';
import 'package:skybase/core/database/secure_storage/secure_storage_manager.dart';
import 'package:skybase/core/helper/dialog_helper.dart';
import 'package:skybase/core/network/api_config.dart';
import 'package:skybase/core/network/api_exception.dart';
import 'package:skybase/core/network/api_request.dart';
import 'package:skybase/core/network/api_response.dart';
import 'package:skybase/core/network/api_url.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
enum TokenType {
  /// When your app no need token authentication.
  NO_TOKEN,

  /// When your app just use Access Token.
  ACCESS_TOKEN,

  /// When your app use Refresh Token Mechanism (Access + Refresh).
  ACCESS_REFRESH_TOKEN,
}

class ApiTokenManager extends QueuedInterceptorsWrapper {
  final authManager = AuthManager.find;
  final secureStorage = SecureStorageManager.find;

  Future<void> handleToken({
    required Dio dio,
    required DioException err,
    required ErrorInterceptorHandler handler,
  }) async {
    switch (AppEnv.config.tokenType) {
      case TokenType.NO_TOKEN:
        super.onError(err, handler);
        break;
      case TokenType.ACCESS_TOKEN:
        // super.onError(err, handler);
        _handleAccessToken(err, handler);
        break;
      case TokenType.ACCESS_REFRESH_TOKEN:
        _handleRefreshToken(dio, err, handler);
        break;
    }
  }

  _handleAccessToken(DioException err, ErrorInterceptorHandler handler) async {
    final int status = err.response?.statusCode ?? 0;
    if (status == 401) {
      SkyDialog.failed(
        isDismissible: false,
        message: 'txt_you_must_login_again'.tr,
        onConfirm: () => authManager.logout(),
      );
      super.onError(err, handler);
    } else {
      super.onError(err, handler);
    }
  }

  _handleRefreshToken(
    Dio dio,
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    String? accessToken = await secureStorage.getToken();
    String? refreshToken = await secureStorage.getRefreshToken();
    if (accessToken != null && err.response?.statusCode == 401) {
      String? newToken =
          await _getAccessToken(refreshToken: refreshToken.toString());
      await secureStorage.setToken(value: newToken.toString());
      return handler.resolve(await _retry(dio, err.requestOptions));
    } else {
      super.onError(err, handler);
    }
  }

  Future<String?> _getAccessToken({required String refreshToken}) async {
    try {
      final responseBody = await Dio().post(
        DioClient.baseURL + ApiUrl.refreshToken,
        data: jsonEncode({'refresh_token': refreshToken}),
        options:
            Options(headers: headers, contentType: Headers.jsonContentType),
      );
      return ApiResponse.fromJson(responseBody.data).data['token'];
    } on DioException catch (error) {
      debugPrint('${NetworkException.getErrorException(error)}');
      return SkyDialog.failed(
        isDismissible: false,
        message: 'txt_you_must_login_again'.tr,
        onConfirm: () => authManager.logout(),
      );
    }
  }

  Future<Response<dynamic>> _retry(
    Dio dio,
    RequestOptions requestOptions,
  ) async {
    String newAccessToken = await secureStorage.getToken() ?? '';
    final options = Options(
        method: requestOptions.method,
        headers: {'Authorization': 'Bearer $newAccessToken'});
    return dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }
}
