import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getx;
import 'package:varcore_flutter_base/core/database/get_storage/get_storage.dart';
import 'package:varcore_flutter_base/core/helper/dialog_helper.dart';
import 'package:varcore_flutter_base/core/network/api_config.dart';
import 'package:varcore_flutter_base/core/network/api_exception.dart';
import 'package:varcore_flutter_base/core/network/api_request.dart';
import 'package:varcore_flutter_base/core/network/api_url.dart';
import 'package:varcore_flutter_base/core/network/api_response.dart';
import 'package:varcore_flutter_base/ui/view/auth/login/login_page.dart';

class ApiInterceptors extends QueuedInterceptorsWrapper {
  final Dio _dio;
  ApiInterceptors(this._dio);

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
    String? accessToken = LocalStorage.to.getToken();
    String? refreshToken = LocalStorage.to.getRefreshToken();
    if (accessToken != null && err.response?.statusCode == 401) {
      String? newToken =
          await _getAccessToken(refreshToken: refreshToken.toString());
      LocalStorage.to.saveToken(newToken.toString());
      return handler.resolve(await _retry(err.requestOptions));
    } else {
      super.onError(err, handler);
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    String newAccessToken = LocalStorage.to.getToken() ?? '';
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
          onPress: () => getx.Get.offAllNamed(LoginPage.route));
    }
  }
}
