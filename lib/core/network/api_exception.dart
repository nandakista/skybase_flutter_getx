import 'package:dio/dio.dart';
import 'package:skybase/core/network/api_message.dart';
import 'package:skybase/core/network/api_response.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class NetworkException implements Exception {
  final String? prefix;
  final Response? response;

  NetworkException({
    this.prefix,
    this.response,
  });

  @override
  String toString() {
    String result = '';
    if (response?.statusCode == 400 || response?.data == 401) {
      ApiResponse _res = ApiResponse.fromJson(response?.data);
      result = ApiMessage.message(_res.error.toString());
    } else {
      result += prefix ?? '';
    }
    return result;
  }

  static NetworkException handleResponse(Response response) {
    var statusCode = response.statusCode!;
    switch (statusCode) {
      case 400:
        return BadRequestException(response: response);
      case 401:
        return UnauthorisedException(response: response);
      case 403:
        return BadRequestException(response: response);
      case 404:
        return NotFoundException(response: response);
      case 409:
        return FetchDataException(response: response);
      case 408:
        return SendTimeOutException();
      case 413:
        return RequestEntityTooLargeException(response: response);
      case 422:
        return BadRequestException(response: response);
      case 500:
        return InternalServerErrorException();
      case 503:
        return InternalServerErrorException();
      default:
        var responseCode = statusCode;
        return FetchDataException(
          message: 'Received invalid status code: $responseCode',
          response: response,
        );
    }
  }

  static NetworkException getErrorException(error) {
    if (error is Exception) {
      try {
        NetworkException networkExceptions;
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              networkExceptions = RequestCancelled();
              break;
            case DioErrorType.connectTimeout:
              networkExceptions = ConnectionTimeOutException();
              break;
            case DioErrorType.other:
              if (error.error is SocketException) {
                networkExceptions = FetchDataException();
              } else {
                networkExceptions = SocketException();
              }
              break;
            case DioErrorType.receiveTimeout:
              networkExceptions = ReceiveTimeOutException();
              break;
            case DioErrorType.response:
              networkExceptions =
                  NetworkException.handleResponse(error.response!);
              break;
            case DioErrorType.sendTimeout:
              networkExceptions = SendTimeOutException();
              break;
          }
        } else if (error is SocketException) {
          networkExceptions = SocketException();
        } else {
          networkExceptions = UnexpectedError();
        }
        return networkExceptions;
      } on FormatException catch (_) {
        return FetchDataException();
      } catch (_) {
        return UnexpectedError();
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return UnableToProcess();
      } else {
        return UnexpectedError();
      }
    }
  }
}

class ConnectionTimeOutException extends NetworkException {
  ConnectionTimeOutException() : super(prefix: 'Connection Timeout');
}

class ReceiveTimeOutException extends NetworkException {
  ReceiveTimeOutException() : super(prefix: 'Receive Timeout');
}

class SendTimeOutException extends NetworkException {
  SendTimeOutException() : super(prefix: 'Send Timeout');
}

class InternalServerErrorException extends NetworkException {
  InternalServerErrorException()
      : super(prefix: 'Mohon maaf, terjadi kesalahan pada Server.');
}

class RequestEntityTooLargeException extends NetworkException {
  RequestEntityTooLargeException({String? message, Response? response})
      : super(prefix: 'Request Entity Too Large', response: response);
}

class FetchDataException extends NetworkException {
  FetchDataException({String? message, Response? response})
      : super(prefix: 'Error During Communication', response: response);
}

class NotFoundException extends NetworkException {
  NotFoundException({String? message, Response? response})
      : super(prefix: 'Alamat tidak ditemukan.', response: response);
}

class BadRequestException extends NetworkException {
  BadRequestException({String? message, Response? response})
      : super(
            prefix: 'Permintaan Ditolak, pesan: ${response?.statusMessage}',
            response: response);
}

class UnauthorisedException extends NetworkException {
  UnauthorisedException({String? message, Response? response})
      : super(prefix: 'Anda harus login terlebih dahulu.', response: response);
}

class InvalidInputException extends NetworkException {
  InvalidInputException({String? message, Response? response})
      : super(prefix: 'Invalid Input', response: response);
}

class RequestCancelled extends NetworkException {
  RequestCancelled({String? message, Response? response})
      : super(prefix: 'Request Cancelled', response: response);
}

class SocketException extends NetworkException {
  SocketException({String? message, Response? response})
      : super(
            prefix: 'Pastikan anda memiliki koneksi internet',
            response: response);
}

class UnexpectedError extends NetworkException {
  UnexpectedError({String? message, Response? response})
      : super(prefix: 'Unexpected Error!', response: response);
}

class UnableToProcess extends NetworkException {
  UnableToProcess({String? message, Response? response})
      : super(prefix: 'Tidak dapat mengirimkan permintaan', response: response);
}
