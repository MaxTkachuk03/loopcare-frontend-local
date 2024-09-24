import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/server_error_data.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

Either<RequestError, T> parseResponse<T>({
  required Either<RequestError, Map<String, dynamic>> response,
  required T Function(Map<String, dynamic>) fromJson,
  required StackTrace stackTrace,
}) {
  return response.fold(
    (l) => left(l),
    (r) {
      try {
        return right(fromJson(r));
      } catch (e) {
        return left(createParsingError(e, stackTrace));
      }
    },
  );
}

Map<String, dynamic> getResponseData(Response? response) {
  if (response == null) return {};
  if (response.data is String) return {};
  // todo: type for downloaded files
  if (response.data is ResponseBody) return {};
  return response.data as Map<String, dynamic>;
}

Either<RequestError, Map<String, dynamic>> handleResponse(Response? response) {
  if (response == null) {
    return const Left(RequestError.unhandledResponse(
        ServerErrorData(message: LocalizedTexts.errorSomethingIsIncorrect)));
  }

  // All Error from BE should be handled by statusCode
  switch (response.statusCode) {
    case HttpStatus.paymentRequired:
      return Left(RequestError.paymentRequired(_getTranslateKey(response)));
    case HttpStatus.badRequest:
      return Left(RequestError.badRequest(_getTranslateKey(response)));
    case HttpStatus.unauthorized:
      return Left(RequestError.unauthorized(_getTranslateKey(response)));
    case HttpStatus.forbidden:
      return Left(RequestError.forbidden(_getTranslateKey(response)));
    case HttpStatus.notFound:
      return Left(RequestError.notFound(_getTranslateKey(response)));
    case HttpStatus.conflict:
      return Left(RequestError.conflict(_getTranslateKey(response)));
    case HttpStatus.internalServerError:
    case HttpStatus.badGateway:
    case HttpStatus.serviceUnavailable:
      return Left(RequestError.serverError(_getTranslateKey(response)));
    case HttpStatus.unprocessableEntity:
      return Left(RequestError.unprocessableEntity(_getTranslateKey(response)));
    default:
      return Right(getResponseData(response));
  }
}

ServerErrorData _getTranslateKey(Response response) {
  if (response.data is String) {
    return ServerErrorData(error: response.data, message: response.data);
  } else {
    final serverErrorData = ServerErrorData.fromJson(response.data);
    return serverErrorData.copyWith(message: serverErrorData.message);
  }
}
