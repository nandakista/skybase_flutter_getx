import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:skybase/core/app/app_env.dart';
import 'package:skybase/core/network/api_interceptor.dart';

final Dio dioClient = Get.find<DioClient>().init();
class DioClient {
  static String baseURL = AppEnv.find.get.baseUrl;

  Dio init() {
    Dio _dio = Dio();
    _dio.options.baseUrl = baseURL;
    _dio.options.connectTimeout = 10 * 1000; //60s
    _dio.options.receiveTimeout = 3 * 1000; //3s
    return _dio;
  }

  static setInterceptor(){
    dioClient.interceptors.clear();
    dioClient.interceptors.add(ApiInterceptors(dioClient));
  }
}