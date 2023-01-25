import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:skybase/core/database/secure_storage/secure_storage_manager.dart';
import 'package:skybase/core/network/api_config.dart';
import 'package:skybase/core/network/api_exception.dart';
import 'package:skybase/core/network/api_url.dart';

// ignore: constant_identifier_names

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
// ignore: constant_identifier_names
enum RequestMethod { GET, POST, PATCH, PUT, DELETE }

Map<String, String> headers = {
  HttpHeaders.authorizationHeader: '',
};

/// Base Request for calling API.
/// * Can be modify as needed.
Future<Response> sendRequest({
  required String url,
  Object? body,
  required RequestMethod requestMethod,
  bool useToken = true,
  String? contentType = Headers.jsonContentType,
}) async {
  await _tokenManager(useToken);
  try {
    switch (requestMethod) {
      case RequestMethod.POST:
        debugPrint('Request Body : ${FormData.fromMap(body as Map<String, dynamic>).fields}');
        return await _safeFetch(
          () => DioClient.find.post(
            url,
            data: _setBody(contentType: contentType, body: body),
            options: Options(headers: headers, contentType: contentType),
          ),
        );
      case RequestMethod.GET:
        return await _safeFetch(
          () => DioClient.find.get(
            url,
            options: Options(headers: headers, contentType: contentType),
          ),
        );
      case RequestMethod.PATCH:
        return await _safeFetch(
          () => DioClient.find.patch(
            url,
            data: _setBody(contentType: contentType, body: body),
            options: Options(headers: headers, contentType: contentType),
          ),
        );
      case RequestMethod.PUT:
        return await _safeFetch(
          () => DioClient.find.put(
            url,
            data: _setBody(contentType: contentType, body: body),
            options: Options(headers: headers, contentType: contentType),
          ),
        );
      case RequestMethod.DELETE:
        return await _safeFetch(
          () => DioClient.find.delete(
            url,
            options: Options(headers: headers),
          ),
        );
    }
  } catch (error) {
    rethrow;
  }
}

Object? _setBody({
  required String? contentType,
  required Object? body,
}) {
  if (contentType == Headers.jsonContentType) {
    body = jsonEncode(body);
  } else if (contentType == Headers.formUrlEncodedContentType) {
    return body;
  } else if (contentType == ApiUrl.multipartFormData) {
    return FormData.fromMap(body as Map<String, dynamic>);
  }
  return null;
}

Future<void> _tokenManager(bool useToken) async {
  DioClient.setInterceptor();
  String? token = await SecureStorageManager.find.getToken();
  if (useToken) {
    // headers[HttpHeaders.authorizationHeader] = 'token $gitToken';
  } else {
    headers.clear();
  }
}

/// Wrap fetch request with try-catch
/// & error handling
Future<Response> _safeFetch(Future<Response> Function() tryFetch) async {
  try {
    final response = await tryFetch();
    // return ApiResponse.fromJson(response.data);
    return response;
  } on DioError catch (e) {
    throw NetworkException.getErrorException(e);
  } catch (e) {
    rethrow;
  }
}
