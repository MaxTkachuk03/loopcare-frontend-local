import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';

Either<RequestError, T> Function(Either<RequestError, Response<dynamic>>) parseResponse<T>(
  T Function(Map<String, dynamic> json) fromJson,
) =>
    (resp) => resp.flatMap(
          (r) {
            try {
              // todo fix string parser
              switch (r.statusCode) {
                case HttpStatus.ok:
                case HttpStatus.noContent:
                case HttpStatus.created:
                case HttpStatus.accepted:
                  if (r.data is String) {
                    return right(r.data);
                  } else {
                    return right(fromJson(r.data));
                  }
                default:
                  return left(handleResponseError(r.statusCode, r.data));
              }
            } catch (error) {
              return left(RequestError.unhandledError(error));
            }
          },
        );
