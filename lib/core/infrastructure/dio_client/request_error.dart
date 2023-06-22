import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_error.freezed.dart';

@freezed
class RequestError with _$RequestError {
  const factory RequestError.requestCancelled(DioError error) =
      _RequestCancelled;

  const factory RequestError.badRequest(DioError error) = _BadRequest;

  const factory RequestError.unauthorized(DioError error) = _UnAuthorized;

  const factory RequestError.forbidden(DioError error) = _Forbidden;

  const factory RequestError.notFound(DioError error) = _NotFound;

  const factory RequestError.conflict(DioError error) = _Conflict;

  const factory RequestError.timeout(DioError error) = _Timeout;

  const factory RequestError.serverError(DioError error) = _InternalServerError;

  const factory RequestError.unhandledResponse(DioError error) =
      _UnhandledResponse;

  const factory RequestError.socketException(SocketException error) =
      _SocketException;

  const factory RequestError.dioOther(DioError error) = _Other;

  const factory RequestError.unhandledError(dynamic error) = _Unhandled;
}
