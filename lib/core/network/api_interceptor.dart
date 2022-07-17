import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:varcore_flutter_base/core/auth_manager/auth_manager.dart';
import 'package:varcore_flutter_base/core/database/secure_storage/secure_storage_manager.dart';
import 'package:varcore_flutter_base/core/helper/dialog_helper.dart';
import 'package:varcore_flutter_base/core/network/api_config.dart';
import 'package:varcore_flutter_base/core/network/api_exception.dart';
import 'package:varcore_flutter_base/core/network/api_request.dart';
import 'package:varcore_flutter_base/core/network/api_url.dart';
import 'package:varcore_flutter_base/core/network/api_response.dart';

class ApiInterceptors extends QueuedInterceptorsWrapper {
  ApiInterceptors(this._dio);
  final Dio _dio;
  final secureStorage = SecureStorageManager.to;
  final authManager = AuthManager.to;

  @override
  Future<dynamic> onRequest(options, handler) async {
    debugPrint('Interceptor ON REQUEST');
    debugPrint('--> ${options.method.toUpperCase()}');
    options.headers
        .forEach((key, value) => debugPrint('Headers : $key: $value'));
    options.queryParameters
        .forEach((key, value) => debugPrint('queryParameters : $key: $value'));
    if (options.data != null) {
      debugPrint('Body: ${options.data}');
    }
    debugPrint('--> END ${options.method.toUpperCase()}');
    return handler.next(options);
  }

  @override
  Future<dynamic> onResponse(Response response, handler) async {
    debugPrint('Interceptor ON RESPONSE');
    debugPrint(
        '<-- ${(response.requestOptions.baseUrl + response.requestOptions.path)}');
    debugPrint('Satus Code : ${response.statusCode} ');
    response.headers
        .forEach((key, value) => debugPrint('Headers : $key: $value'));
    debugPrint('Response: ${response.data}');
    debugPrint('<-- END HTTP');
    return super.onResponse(response, handler);
  }

  @override
  Future<dynamic> onError(DioError err, handler) async {
    debugPrint('Interceptor ON ERROR');
    debugPrint(
        '<-- ${err.response?.requestOptions.baseUrl}, ${err.response?.requestOptions.path}');
    debugPrint('Status Code : ${err.response?.statusCode} ');
    debugPrint('Error Message : ${err.response?.statusMessage} ');
    debugPrint('Error Message : ${err.message} ');
    debugPrint('<-- End error');

    // _handleRefreshToken(err, handler);
    super.onError(err, handler);
  }

  _handleRefreshToken(DioError err, ErrorInterceptorHandler handler) async {
    String? accessToken = await secureStorage.getToken();
    String? refreshToken = await secureStorage.getRefreshToken();
    if (accessToken != null && err.response?.statusCode == 401) {
      String? newToken =
          await _getAccessToken(refreshToken: refreshToken.toString());
      await secureStorage.setToken(value: newToken.toString());
      return handler.resolve(await _retry(err.requestOptions));
    } else {
      super.onError(err, handler);
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    String newAccessToken = await secureStorage.getToken() ?? '';
    final options = Options(
        method: requestOptions.method,
        headers: {'Authorization': 'Bearer $newAccessToken'});
    return _dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
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
    } on DioError catch (error) {
      debugPrint('${DioException.message(error)}');
      return AppDialog.show(
          typeDialog: TypeDialog.FAILED,
          dismissible: false,
          message: 'Anda harus login kembali!',
          onPress: () => authManager.logout());
    }
  }
}
