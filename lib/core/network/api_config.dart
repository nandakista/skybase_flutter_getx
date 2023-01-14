import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:skybase/core/app/app_env.dart';
import 'package:skybase/core/network/api_interceptor.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class DioClient extends GetxService {
  static String baseURL = AppEnv.config.baseUrl;
  late Dio _dio;
  static Dio get find => Get.find<DioClient>()._dio;

  @override
  void onInit() {
    _dio = Dio();
    _dio.options.baseUrl = baseURL;
    _dio.options.connectTimeout = 60 * 1000; //60s
    _dio.options.receiveTimeout = 3 * 1000; //3s
    super.onInit();
  }

  static setInterceptor(){
    DioClient.find.interceptors.clear();
    DioClient.find.interceptors.add(ApiInterceptors(DioClient.find));
  }
}