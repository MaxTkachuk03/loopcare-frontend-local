import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/server_error_data.dart';

RequestError parseRequestError(dynamic error) {
  if (error is Exception) {
    if (error is DioError) {
      final ServerErrorData serverError = ServerErrorData.fromJson(jsonDecode(error.response.toString()));

      switch (error.type) {
        case DioErrorType.cancel:
          return RequestError.requestCancelled(serverError);
        case DioErrorType.connectTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.sendTimeout:
          return RequestError.timeout(serverError);
        case DioErrorType.response:
          return _handleResponseError(serverError);
        case DioErrorType.other:
          if (error.message.contains('SocketException')) {
            return const RequestError.socketException(
              SocketException('Dio SocketException'),
            );
          }

          return RequestError.dioOther(serverError);
        default:
          return RequestError.unhandledError(error);
      }
    }

    if (error is SocketException) {
      return RequestError.socketException(error);
    }
  }

  return RequestError.unhandledError(error);
}

RequestError _handleResponseError(ServerErrorData error) {
  switch (error.statusCode) {
    case HttpStatus.badRequest:
      return RequestError.badRequest(error);
    case HttpStatus.unauthorized:
      return RequestError.unauthorized(error);
    case HttpStatus.forbidden:
      return RequestError.forbidden(error);
    case HttpStatus.notFound:
      return RequestError.notFound(error);
    case HttpStatus.conflict:
      return RequestError.conflict(error);
    case HttpStatus.internalServerError:
    case HttpStatus.badGateway:
    case HttpStatus.serviceUnavailable:
      return RequestError.serverError(error);
    case HttpStatus.unprocessableEntity:
      return RequestError.unprocessableEntity(error);
    default:
      return RequestError.unhandledResponse(error);
  }
}
