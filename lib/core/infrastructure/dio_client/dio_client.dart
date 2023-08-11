import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_options.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/auth_token_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum DioRequestCancellationReason {
  seachManualCancel,
}

Future<Either<RequestError, T>> process<T>(Future<T> Function() request) => Task(request)
    .attempt()
    .map(
      (e) => e.leftMap(parseRequestError),
    )
    .run();

@lazySingleton
class DioClient {
  late final Dio dio;
  final AuthTokenInterceptor _authTokenInterceptor;
  final SharedPreferences sharedPreferences;

  DioClient(this._authTokenInterceptor, this.sharedPreferences) {
    dio = dioOptions;

    dio.interceptors.add(_authTokenInterceptor);

    if (dotenv.env['NEED_DIO_LOGGER'] == 'true') {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          // responseHeader: true,
        ),
      );
    }
    if (const String.fromEnvironment('FLAVOR') == 'dev') {
      dio.httpClientAdapter = _createAdapter();
    }
  }

  HttpClientAdapter _createAdapter() => DefaultHttpClientAdapter()
    ..onHttpClientCreate = (client) => client
      ..findProxy = _findProxy
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;

  String _findProxy(Uri url) {
    final ip = sharedPreferences.getString('_ip');
    final port = sharedPreferences.getString('_port');

    bool hasProxy = ip != null && ip.isNotEmpty && port != null && port.isNotEmpty;

    return hasProxy ? 'PROXY $ip:$port' : 'DIRECT';
  }

  void cancelRequests({CancelToken? cancelToken}) {
    if (cancelToken != null) {
      cancelToken.cancel();
    }
  }

  Future<Either<RequestError, Response<dynamic>>> get(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    String? baseUrl,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return process(() => dio.get(
          path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
        ));
  }

  Future<Either<RequestError, Response<dynamic>>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    String? baseUrl,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return process(() => dio.post(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        ));
  }

  Future<Either<RequestError, Response<dynamic>>> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    String? baseUrl,
    CancelToken? cancelToken,
  }) async {
    return process(() => dio.delete(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ));
  }

  Future<Either<RequestError, Response<dynamic>>> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    String? baseUrl,
    CancelToken? cancelToken,
  }) async {
    return process(() => dio.patch(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ));
  }

  Future<Either<RequestError, Response<dynamic>>> downloading(
    String path,
    String savePath, {
    Map<String, dynamic>? queryParameters,
    bool withInterceptor = true,
    bool withRetryInterceptor = false,
  }) async {
    return process(() => dio.download(
          path,
          savePath,
          queryParameters: queryParameters,
        ));
  }
}
