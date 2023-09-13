import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/server_error_data.dart';

part 'request_error.freezed.dart';

@freezed
class RequestError with _$RequestError {
  const factory RequestError.requestCancelled(ServerErrorData error) = _RequestCancelled;

  const factory RequestError.badRequest(ServerErrorData error) = _BadRequest;

  const factory RequestError.unauthorized(ServerErrorData error) = _UnAuthorized;

  const factory RequestError.forbidden(ServerErrorData error) = _Forbidden;

  const factory RequestError.notFound(ServerErrorData error) = _NotFound;

  const factory RequestError.conflict(ServerErrorData error) = _Conflict;

  const factory RequestError.timeout(ServerErrorData error) = _Timeout;

  const factory RequestError.serverError(ServerErrorData error) = _InternalServerError;

  const factory RequestError.unprocessableEntity(ServerErrorData error) = _UnprocessableEntity;

  const factory RequestError.unhandledResponse(ServerErrorData error) = _UnhandledResponse;

  const factory RequestError.socketException(SocketException error) = _SocketException;

  const factory RequestError.dioOther(ServerErrorData error) = _Other;

  const factory RequestError.unhandledError(dynamic error) = _Unhandled;
}
