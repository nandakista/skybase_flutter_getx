import 'package:dio/dio.dart';
import 'package:skybase/core/network/api_message.dart';
import 'package:skybase/core/network/api_response.dart';

class DioException {
  static message(DioError dioError){
    if (dioError.type == DioErrorType.connectTimeout) {
      return 'Request timeout';
    } else {
      switch (dioError.response?.statusCode) {
        case 400 :
          return ApiMessage.message(ApiResponse.fromJson(dioError.response?.data).error);
        case 401 :
          return ApiMessage.message('Anda harus login terlebih dahulu.');
        case 404 :
          return ApiMessage.message('Alamat tidak ditemukan: ${dioError.response?.statusCode}');
        case 422 :
          return ApiMessage.message('Permintaan Ditolak, pesan: ${dioError.response?.statusMessage}');
        case 500 :
          return ApiMessage.message('Mohon maaf, terjadi kesalahan pada Server.');
        case 502 :
          return ApiMessage.message('Mohon maaf, terjadi kesalahan pada Server.');
        default:
          var status = dioError.response?.statusCode;
          var message = dioError.response?.statusMessage;
          status ??= 504;
          message ??= 'Timeout';
          return 'Terjadi kesalahan! \n($status : $message)';
      }
    }
  }
}