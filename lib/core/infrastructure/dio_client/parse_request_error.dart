import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/server_error_data.dart';
import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

RequestError createParsingError(dynamic e, StackTrace stackTrace) {
  log.e(e.toString(), error: LogTitle.parsingError, stackTrace: stackTrace);
  return RequestError.parsingError(e);
}

Either<RequestError, T> handleDioException<T>(dynamic error) {
  if (error is Exception) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.cancel:
          return Left(RequestError.requestCancelled(error));
        case DioExceptionType.connectionError:
          return Left(RequestError.connection(error));
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          return Left(RequestError.timeout(error));
        case DioExceptionType.badResponse:
          return Left(_handleError(error));
        case DioExceptionType.unknown:
          if (error.message?.contains('SocketException') ?? false) {
            return const Left(
              RequestError.socketException(
                SocketException('Dio SocketException'),
              ),
            );
          }
          return Left(RequestError.dioOther(error));
        default:
          return Left(RequestError.unhandledError(error));
      }
    }

    if (error is SocketException) {
      return Left(RequestError.socketException(error));
    }
  }
  return Left(RequestError.unhandledError(error));
}

RequestError _handleError(DioException error) {
  final ServerErrorData serverError = ServerErrorData.fromJson(jsonDecode(error.response.toString()));
  switch (serverError.statusCode) {
    case HttpStatus.badRequest:
      return const RequestError.badRequest(ServerErrorData(message: LocalizedTexts.errorBadRequestDio));
    case HttpStatus.unauthorized:
      return const RequestError.unauthorized(ServerErrorData(message: LocalizedTexts.errorUnauthorizedDio));
    case HttpStatus.forbidden:
      return const RequestError.forbidden(ServerErrorData(message: LocalizedTexts.errorForbiddenDio));
    case HttpStatus.notFound:
      return const RequestError.notFound(ServerErrorData(message: LocalizedTexts.errorNotFoundDio));
    case HttpStatus.conflict:
      return const RequestError.conflict(ServerErrorData(message: LocalizedTexts.errorConflictDio));
    case HttpStatus.internalServerError:
    case HttpStatus.badGateway:
    case HttpStatus.serviceUnavailable:
      return const RequestError.serverError(ServerErrorData(message: LocalizedTexts.errorServerErrorDio));
    case HttpStatus.unprocessableEntity:
      return const RequestError.unprocessableEntity(ServerErrorData(message: LocalizedTexts.errorUnprocessableEntityDio));
    default:
      return const RequestError.unhandledResponse(ServerErrorData(message: LocalizedTexts.errorUnhandledResponseDio));
  }
}
