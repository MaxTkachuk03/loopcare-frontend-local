import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';

Either<RequestError, T> Function(Either<RequestError, Response<dynamic>>) parseResponse<T>(
  T Function(Map<String, dynamic> json) fromJson,
) =>
    (resp) => resp.flatMap(
          (r) {
            try {
              final json = r.data as Map<String, dynamic>;
              switch (r.statusCode) {
                case HttpStatus.ok:
                case HttpStatus.noContent:
                case HttpStatus.created:
                case HttpStatus.accepted:
                  return right(fromJson(json));
                default:
                  return left(handleResponseError(r.statusCode, json));
              }
            } catch (error) {
              debugPrint('devcpp parseResponse ${error.toString()}');
              return left(RequestError.unhandledError(error));
            }
          },
        );
