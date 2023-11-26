import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/server_error_data.dart';

Either<RequestError, T> Function(Either<RequestError, Response<dynamic>>) parseResponse<T>(
  T Function(Map<String, dynamic> json) fromJson,
) =>
    (resp) => resp.flatMap(
          (r) {
            try {
              final json = r.data as Map<String, dynamic>;
              debugPrint('devcpp parseResponse: ${json.toString()}');
              switch (r.statusCode) {
                case HttpStatus.ok:
                case HttpStatus.noContent:
                case HttpStatus.created:
                case HttpStatus.accepted:
                  return right(fromJson(json));
                default:
                  return left(_handleResponseError(r.statusCode, json));
              }
            } catch (error) {
              return left(RequestError.unhandledError(error));
            }
          },
        );

RequestError _handleResponseError(int? statusCode, dynamic json) {
  final ServerErrorData serverError = ServerErrorData.fromJson(json);
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
