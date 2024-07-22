import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/server_error_data.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

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
    return const Left(RequestError.unhandledResponse(ServerErrorData(message: LocalizedTexts.somethingIsIncorrect)));
  }

  // All Error from BE should be handled by statusCode
  switch (response.statusCode) {
    case HttpStatus.paymentRequired:
      return Left(RequestError.paymentRequired(_translateMessage(response)));
    case HttpStatus.badRequest:
      return Left(RequestError.badRequest(_translateMessage(response)));
    case HttpStatus.unauthorized:
      return Left(RequestError.unauthorized(_translateMessage(response)));
    case HttpStatus.forbidden:
      return Left(RequestError.forbidden(_translateMessage(response)));
    case HttpStatus.notFound:
      return Left(RequestError.notFound(_translateMessage(response)));
    case HttpStatus.conflict:
      return Left(RequestError.conflict(_translateMessage(response)));
    case HttpStatus.internalServerError:
    case HttpStatus.badGateway:
    case HttpStatus.serviceUnavailable:
      return Left(RequestError.serverError(_translateMessage(response)));
    case HttpStatus.unprocessableEntity:
      return Left(RequestError.unprocessableEntity(_translateMessage(response)));
    default:
      return Right(getResponseData(response));
  }
}

ServerErrorData _translateMessage(Response response) {
  final serverErrorData = ServerErrorData.fromJson(response.data);
  return serverErrorData.copyWith(message: serverErrorData.message?.tr());
}
