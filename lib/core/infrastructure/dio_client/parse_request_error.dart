import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/server_error_data.dart';

RequestError parseRequestError(dynamic error) {
  if (error is Exception) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.cancel:
          return RequestError.requestCancelled(error);
        case DioExceptionType.connectionError:
          return RequestError.connection(error);
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          return RequestError.timeout(error);
        case DioExceptionType.badResponse:
          return _handleResponseError(error);
        case DioExceptionType.unknown:
          if (error.message?.contains('SocketException') ?? false) {
            return const RequestError.socketException(
              SocketException('Dio SocketException'),
            );
          }
          return RequestError.dioOther(error);
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

RequestError _handleResponseError(DioException error) {
  final ServerErrorData serverError = ServerErrorData.fromJson(jsonDecode(error.response.toString()));

  switch (serverError.statusCode) {
    case HttpStatus.badRequest:
      return RequestError.badRequest(serverError);
    case HttpStatus.unauthorized:
      return RequestError.unauthorized(serverError);
    case HttpStatus.forbidden:
      return RequestError.forbidden(serverError);
    case HttpStatus.notFound:
      return RequestError.notFound(serverError);
    case HttpStatus.conflict:
      return RequestError.conflict(serverError);
    case HttpStatus.internalServerError:
    case HttpStatus.badGateway:
    case HttpStatus.serviceUnavailable:
      return RequestError.serverError(serverError);
    case HttpStatus.unprocessableEntity:
      return RequestError.unprocessableEntity(serverError);
    default:
      return RequestError.unhandledResponse(serverError);
  }
}
