import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:varcore_flutter_base/core/database/get_storage.dart';
import 'package:varcore_flutter_base/core/network/api_config.dart';
import 'package:varcore_flutter_base/core/network/api_exception.dart';
import 'package:varcore_flutter_base/core/network/api_message.dart';
import 'package:varcore_flutter_base/core/network/api_response.dart';

enum RequestMethod { GET, POST, PATCH, PUT, DELETE }

Map<String, String> headers = {
  HttpHeaders.authorizationHeader: '',
  // 'Client-Token': 'EY5WGBIXosmK5f2Jckxt52Gm9p8sv1VEMjYzozArzb0=',
};

Future<Response> sendRequest({
  required String url,
  Object? body,
  required RequestMethod requestMethod,
  bool useToken = false,
  String? contentType = Headers.jsonContentType,
}) async {
  DioClient.setInterceptor();
  var apiToken = LocalStorage.to.isLoggedIn() ? LocalStorage.to.getToken() : null;
  if (useToken) {
    headers[HttpHeaders.authorizationHeader] = 'Bearer $apiToken';
  } else {
    headers.clear();
  }
  try {
    Response response;
    switch (requestMethod) {
      case RequestMethod.POST:
        try {
          debugPrint('Request Body : ${FormData.fromMap(body as Map<String, dynamic>).fields}');
          response = await dioClient.post(
            url,
            data: contentType == Headers.jsonContentType
                ? jsonEncode(body)
                : FormData.fromMap(body),
            options: Options(headers: headers, contentType: contentType),
          );
        } on SocketException {
          throw 'Tidak ada koneksi internet!';
        } on DioError catch (error) {
          throw DioException.message(error);
        }
        break;
      case RequestMethod.GET:
        try {
          response = await dioClient.get(
            url,
            options: Options(contentType: contentType, headers: headers),
          );
        } on SocketException {
          throw 'Tidak ada koneksi internet!';
        } on DioError catch (error) {
          throw DioException.message(error);
        }
        break;
      case RequestMethod.PATCH:
        try {
          response = await dioClient.patch(
            url,
            data: contentType == Headers.jsonContentType
                ? jsonEncode(body)
                : FormData.fromMap(body as Map<String, dynamic>),
            options: Options(headers: headers, contentType: contentType),
          );
        } on SocketException {
          throw 'Tidak ada koneksi internet!';
        } on DioError catch (error) {
          throw DioException.message(error);
        }
        break;
      case RequestMethod.PUT:
        try {
          response = await dioClient.put(
            url,
            data: contentType == Headers.jsonContentType
                ? jsonEncode(body)
                : FormData.fromMap(body as Map<String, dynamic>),
            options: Options(headers: headers, contentType: contentType),
          );
        } on SocketException {
          throw 'Tidak ada koneksi internet!';
        } on DioError catch (error) {
          throw DioException.message(error);
        }
        break;
      case RequestMethod.DELETE:
        try {
          response = await dioClient.delete(
            url,
            options: Options(headers: headers),
          );
        } on SocketException {
          throw 'Tidak ada koneksi internet!';
        } on DioError catch (error) {
          throw DioException.message(error);
        }
        break;
    }
    return response;
  } catch (error) {
    rethrow;
  }
}
