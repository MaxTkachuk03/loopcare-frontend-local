import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';

Either<RequestError, T> Function(Either<RequestError, Response<dynamic>>)
    parseResponse<T>(
  T Function(Map<String, dynamic> json) fromJson,
) =>
        (resp) => resp.flatMap(
              (r) {
                try {
                  final json = r.data as Map<String, dynamic>;

                  return right(fromJson(json));
                } catch (error) {
                  return left(RequestError.unhandledError(error));
                }
              },
            );
