import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:skybase/config/environment/app_env.dart';
import 'package:skybase/config/network/api_interceptor.dart';

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
    _dio.options.connectTimeout = const Duration(seconds: 30); //30s
    _dio.options.receiveTimeout = const Duration(seconds: 30); //30s
    super.onInit();
  }

  static setInterceptor() {
    DioClient.find.interceptors.clear();
    DioClient.find.interceptors.add(ApiInterceptors(DioClient.find));
  }
}
