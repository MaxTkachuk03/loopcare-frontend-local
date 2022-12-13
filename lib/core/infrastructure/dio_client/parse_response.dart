import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';

Either<RequestError, T> Function(Response<dynamic>) parseResponse<T>(
        T Function(Map<String, dynamic> json) fromJson) =>
    (Response response) {
      try {
        final json = response.data as Map<String, dynamic>;

        return right(fromJson(json));
      } on DioError catch (error) {
        final errorMessage = parseRequestError(error);
        throw left(errorMessage);
      }
    };
