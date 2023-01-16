import 'package:dio/dio.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
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
      ApiResponse res = ApiResponse.fromJson(response?.data);
      result = ApiMessage.message(res.error.toString());
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
  ConnectionTimeOutException() : super(prefix: 'txt_connection_timeout'.tr);
}

class ReceiveTimeOutException extends NetworkException {
  ReceiveTimeOutException() : super(prefix: 'txt_connection_timeout'.tr);
}

class SendTimeOutException extends NetworkException {
  SendTimeOutException() : super(prefix: 'txt_connection_timeout'.tr);
}

class InternalServerErrorException extends NetworkException {
  InternalServerErrorException()
      : super(prefix: 'txt_internal_server_error'.tr);
}

class RequestEntityTooLargeException extends NetworkException {
  RequestEntityTooLargeException({String? message, Response? response})
      : super(prefix: 'txt_request_entity_to_large'.tr, response: response);
}

class FetchDataException extends NetworkException {
  FetchDataException({String? message, Response? response})
      : super(prefix: 'txt_error_during_communication'.tr, response: response);
}

class NotFoundException extends NetworkException {
  NotFoundException({String? message, Response? response})
      : super(prefix: 'txt_not_found'.tr, response: response);
}

class BadRequestException extends NetworkException {
  BadRequestException({String? message, Response? response})
      : super(
            prefix:
                '${'txt_bad_request'.tr}, ${'txt_message'.tr}: ${response?.statusMessage}',
            response: response);
}

class UnauthorisedException extends NetworkException {
  UnauthorisedException({String? message, Response? response})
      : super(prefix: 'txt_unauthorized'.tr, response: response);
}

class InvalidInputException extends NetworkException {
  InvalidInputException({String? message, Response? response})
      : super(prefix: 'txt_invalid_input'.tr, response: response);
}

class RequestCancelled extends NetworkException {
  RequestCancelled({String? message, Response? response})
      : super(prefix: 'txt_request_cancel'.tr, response: response);
}

class SocketException extends NetworkException {
  SocketException({String? message, Response? response})
      : super(prefix: 'txt_no_internet_connection'.tr, response: response);
}

class UnexpectedError extends NetworkException {
  UnexpectedError({String? message, Response? response})
      : super(prefix: 'txt_unexpected_error'.tr, response: response);
}

class UnableToProcess extends NetworkException {
  UnableToProcess({String? message, Response? response})
      : super(prefix: 'txt_unable_to_process'.tr, response: response);
}
