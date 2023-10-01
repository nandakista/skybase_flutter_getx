import 'package:dio/dio.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:skybase/config/network/api_message.dart';
import 'package:skybase/config/network/api_response.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/

sealed class NetworkExceptionData with ApiMessage {
  final String? prefix;
  final String? message;
  final Response? response;

  NetworkExceptionData({
    this.prefix,
    this.message,
    this.response,
  });

  @override
  String toString() {
    String result = '';
    if (response?.statusCode == 400 || response?.statusCode == 401) {
      ApiResponse res = ApiResponse.fromJson(response?.data);
      result = convertMessage(res.error ?? res.message);
    } else {
      result += (prefix != null) ? '$prefix, $message' : '$message';
    }
    return result;
  }
}

mixin NetworkException implements Exception {
  NetworkExceptionData handleResponse(Response response) {
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

  NetworkExceptionData getErrorException(error) {
    if (error is Exception) {
      try {
        NetworkExceptionData networkExceptions;
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              networkExceptions = RequestCancelled();
              break;
            case DioExceptionType.connectionTimeout:
              networkExceptions = ConnectionTimeOutException();
              break;
            case DioExceptionType.unknown:
              if (error.error is SocketException) {
                networkExceptions = SocketException();
              } else {
                networkExceptions = FetchDataException();
              }
              break;
            case DioExceptionType.receiveTimeout:
              networkExceptions = ReceiveTimeOutException();
              break;
            case DioExceptionType.badResponse:
              networkExceptions = handleResponse(error.response!);
              break;
            case DioExceptionType.sendTimeout:
              networkExceptions = SendTimeOutException();
              break;
            case DioExceptionType.badCertificate:
              networkExceptions = BadCertificateException();
              break;
            case DioExceptionType.connectionError:
              networkExceptions = ConnectionTimeOutException();
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

final class ConnectionTimeOutException extends NetworkExceptionData {
  ConnectionTimeOutException() : super(message: 'txt_connection_timeout'.tr);
}

final class ReceiveTimeOutException extends NetworkExceptionData {
  ReceiveTimeOutException() : super(message: 'txt_connection_timeout'.tr);
}

final class SendTimeOutException extends NetworkExceptionData {
  SendTimeOutException() : super(message: 'txt_connection_timeout'.tr);
}

final class InternalServerErrorException extends NetworkExceptionData {
  InternalServerErrorException()
      : super(message: 'txt_internal_server_error'.tr);
}

final class RequestEntityTooLargeException extends NetworkExceptionData {
  RequestEntityTooLargeException({Response? response})
      : super(message: 'txt_request_entity_to_large'.tr, response: response);
}

final class FetchDataException extends NetworkExceptionData {
  FetchDataException({String? message, Response? response})
      : super(
            message: message ?? 'txt_error_during_communication'.tr,
            response: response);
}

final class NotFoundException extends NetworkExceptionData {
  NotFoundException({String? message, Response? response})
      : super(message: message ?? 'txt_not_found'.tr, response: response);
}

final class BadRequestException extends NetworkExceptionData {
  BadRequestException({Response? response})
      : super(
            prefix: 'txt_bad_request'.tr,
            message: '${'txt_message'.tr}: ${response?.statusMessage}',
            response: response);
}

final class BadCertificateException extends NetworkExceptionData {
  BadCertificateException({Response? response})
      : super(message: 'txt_bad_certificate'.tr, response: response);
}

final class UnauthorisedException extends NetworkExceptionData {
  UnauthorisedException({Response? response})
      : super(message: 'txt_unauthorized'.tr, response: response);
}

final class InvalidInputException extends NetworkExceptionData {
  InvalidInputException({Response? response})
      : super(message: 'txt_invalid_input'.tr, response: response);
}

final class RequestCancelled extends NetworkExceptionData {
  RequestCancelled({Response? response})
      : super(message: 'txt_request_cancel'.tr, response: response);
}

final class SocketException extends NetworkExceptionData {
  SocketException({Response? response})
      : super(message: 'txt_no_internet_connection'.tr, response: response);
}

final class UnexpectedError extends NetworkExceptionData {
  UnexpectedError({Response? response})
      : super(message: 'txt_unexpected_error'.tr, response: response);
}

final class UnableToProcess extends NetworkExceptionData {
  UnableToProcess({Response? response})
      : super(message: 'txt_unable_to_process'.tr, response: response);
}
