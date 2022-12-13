import 'dart:io';

import 'package:dio/dio.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';

RequestError parseRequestError(DioError error) {
  switch (error.type) {
    case DioErrorType.cancel:
      return RequestError.requestCancelled(error);
    case DioErrorType.connectTimeout:
    case DioErrorType.receiveTimeout:
    case DioErrorType.sendTimeout:
      return RequestError.timeout(error);
    case DioErrorType.response:
      return _handleResponseError(error);
    case DioErrorType.other:
      if (error.message.contains('SocketException')) {
        return const RequestError.socketException(
          SocketException('Dio SocketException'),
        );
      }

      return RequestError.dioOther(error);
    default:
      return RequestError.unhandledError(error);
  }
}

RequestError _handleResponseError(DioError error) {
  final statusCode = error.response?.statusCode;

  switch (statusCode) {
    case HttpStatus.badRequest:
      return RequestError.badRequest(error);
    case HttpStatus.unauthorized:
      return RequestError.unauthorized(error);
    case HttpStatus.forbidden:
      return RequestError.forbidden(error);
    case HttpStatus.notFound:
      return RequestError.notFound(error);
    case HttpStatus.internalServerError:
    case HttpStatus.badGateway:
    case HttpStatus.serviceUnavailable:
      return RequestError.serverError(error);
    default:
      return RequestError.unhandledResponse(error);
  }
}
