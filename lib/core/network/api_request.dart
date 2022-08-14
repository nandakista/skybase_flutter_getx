import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:skybase/core/database/secure_storage/secure_storage_manager.dart';
import 'package:skybase/core/network/api_config.dart';
import 'package:skybase/core/network/api_exception.dart';

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
  _tokenManager(useToken);
  try {
    switch (requestMethod) {
      case RequestMethod.POST:
        debugPrint(
            'Request Body : ${FormData.fromMap(body as Map<String, dynamic>).fields}');
        return await _safeFetch(
          () => dioClient.post(
            url,
            data: contentType == Headers.jsonContentType
                ? jsonEncode(body)
                : FormData.fromMap(body),
            options: Options(headers: headers, contentType: contentType),
          ),
        );
      case RequestMethod.GET:
        return await _safeFetch(
          () => dioClient.get(
            url,
            options: Options(headers: headers, contentType: contentType),
          ),
        );
      case RequestMethod.PATCH:
        return await _safeFetch(
          () => dioClient.patch(
            url,
            data: contentType == Headers.jsonContentType
                ? jsonEncode(body)
                : FormData.fromMap(body as Map<String, dynamic>),
            options: Options(headers: headers, contentType: contentType),
          ),
        );
      case RequestMethod.PUT:
        return await _safeFetch(
          () => dioClient.put(
            url,
            data: contentType == Headers.jsonContentType
                ? jsonEncode(body)
                : FormData.fromMap(body as Map<String, dynamic>),
            options: Options(headers: headers, contentType: contentType),
          ),
        );
      case RequestMethod.DELETE:
        return await _safeFetch(
          () => dioClient.delete(
            url,
            options: Options(headers: headers),
          ),
        );
    }
  } catch (error) {
    rethrow;
  }
}

void _tokenManager(bool useToken) async {
  final secureStorage = SecureStorageManager.find;
  DioClient.setInterceptor();
  String? token = await secureStorage.getToken();
  if (useToken) {
    // headers[HttpHeaders.authorizationHeader] = token.toString();
    headers[HttpHeaders.authorizationHeader] = 'token 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';
  } else {
    headers.clear();
  }
}

/// Wrap fetch request with try-catch
/// & error handling
Future<Response> _safeFetch(Future<Response> Function() tryFetch) async {
  try {
    final response = await tryFetch();
    return response;
  } on DioError catch (e) {
    throw DioException.message(e);
  } on SocketException catch (e) {
    throw SocketException(e.toString());
  } on FormatException catch (_) {
    throw const FormatException('Unable to process the data');
  } catch (e) {
    rethrow;
  }
}


