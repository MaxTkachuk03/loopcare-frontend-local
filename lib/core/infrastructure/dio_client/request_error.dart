import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/server_error_data.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

part 'request_error.freezed.dart';

@freezed
class RequestError with _$RequestError {
  const RequestError._();

  //DioException
  const factory RequestError.dioOther(DioException error) = _Other;

  const factory RequestError.connection(DioException error) = _Connection;

  const factory RequestError.timeout(DioException error) = _Timeout;

  const factory RequestError.requestCancelled(DioException error) = _RequestCancelled;

  const factory RequestError.unhandledError(dynamic error) = _Unhandled;

  //SocketException
  const factory RequestError.socketException(SocketException error) = _SocketException;

  //String
  const factory RequestError.parsingError(dynamic error) = _ParsingError;

  //ServerError
  const factory RequestError.streamSubscription(ServerErrorData error) = _StreamSubscription;

  const factory RequestError.badRequest(ServerErrorData error) = _BadRequest;

  const factory RequestError.paymentRequired(ServerErrorData error) = _PaymentRequired;

  const factory RequestError.unauthorized(ServerErrorData error) = _UnAuthorized;

  const factory RequestError.forbidden(ServerErrorData error) = _Forbidden;

  const factory RequestError.notFound(ServerErrorData error) = _NotFound;

  const factory RequestError.conflict(ServerErrorData error) = _Conflict;

  const factory RequestError.serverError(ServerErrorData error) = _InternalServerError;

  const factory RequestError.unprocessableEntity(ServerErrorData error) = _UnprocessableEntity;

  const factory RequestError.unhandledResponse(ServerErrorData error) = _UnhandledResponse;

  String get message => map(
        dioOther: (_) => LocalizedTexts.errorOtherDio,
        connection: (_) => LocalizedTexts.errorConnectionDio,
        timeout: (_) => LocalizedTexts.errorTimeoutDio,
        requestCancelled: (_) => LocalizedTexts.errorRequestCancelledDio,
        unhandledError: (_) => LocalizedTexts.errorUnhandledErrorDio,
        socketException: (e) => LocalizedTexts.errorSocketException,
        streamSubscription: (e) => e.error.message ?? LocalizedTexts.errorSomethingWentWrong,
        parsingError: (e) => LocalizedTexts.errorParsingException,
        badRequest: (e) => e.error.message ?? LocalizedTexts.errorSomethingWentWrong,
        paymentRequired: (e) => e.error.message ?? LocalizedTexts.errorSomethingWentWrong,
        unauthorized: (e) => e.error.message ?? LocalizedTexts.errorSomethingWentWrong,
        forbidden: (e) => e.error.message ?? LocalizedTexts.errorSomethingWentWrong,
        notFound: (e) => e.error.message ?? LocalizedTexts.errorSomethingWentWrong,
        conflict: (e) => e.error.message ?? LocalizedTexts.errorSomethingWentWrong,
        serverError: (e) => e.error.message ?? LocalizedTexts.errorSomethingWentWrong,
        unprocessableEntity: (e) => e.error.message ?? LocalizedTexts.errorSomethingWentWrong,
        unhandledResponse: (e) => e.error.message ?? LocalizedTexts.errorSomethingWentWrong,
      );
}
