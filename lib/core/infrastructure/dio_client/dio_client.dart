import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/build_type.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/app_version_interceptor.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/auth_token_interceptor.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_options.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/error_interceptor.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/retry.dart';
import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

enum FetchType { get, post, put, delete, patch, downloading }

enum DioRequestCancellationReason {
  searchManualCancel,
}

@lazySingleton
class DioClient {
  late final Dio dio;
  final AppVersionInterceptor _appVersionInterceptor;
  final AuthTokenInterceptor _authTokenInterceptor;
  final ErrorInterceptor _errorInterceptor;
  final SharedStorageService sharedPreferences;

  DioClient(
    this._appVersionInterceptor,
    this._authTokenInterceptor,
    this._errorInterceptor,
    this.sharedPreferences,
  ) {
    dio = dioOptions;

    dio.interceptors.addAll([
      _authTokenInterceptor,
      _appVersionInterceptor,
      _errorInterceptor,
    ]);

    _configureRetryConnection();

    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: false,
        error: true,
        compact: true,
      ));
    }

    if (kIsDev) {
      dio.httpClientAdapter = _createAdapter();
    }
  }

  void _configureRetryConnection() {
    dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: dio,
          connectivity: Connectivity(),
        ),
      ),
    );
  }

  HttpClientAdapter _createAdapter() => IOHttpClientAdapter(
        createHttpClient: () {
          // Don't trust any certificate just because their root cert is trusted.
          final HttpClient client = HttpClient(context: SecurityContext(withTrustedRoots: false));
          // You can test the intermediate / root cert here. We just ignore it.
          client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
          client.findProxy = _findProxy;
          return client;
        },
      );

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

  Future<Either<RequestError, T>> get<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic>) fromJson,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onReceiveProgress,
  }) =>
      fetchResponse(
        dio,
        path,
        FetchType.get,
        data: data,
        fromJson: fromJson,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options,
        onReceiveProgress: onReceiveProgress,
      );

  Future<Either<RequestError, T>> post<T>(
    String path, {
    dynamic data = const {},
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) =>
      fetchResponse(
        dio,
        path,
        FetchType.post,
        data: data,
        fromJson: fromJson,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

  Future<Either<RequestError, T>> put<T>(
    String path, {
    dynamic data = const {},
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic>) fromJson,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) =>
      fetchResponse(
        dio,
        path,
        FetchType.put,
        data: data,
        fromJson: fromJson,
        queryParameters: queryParameters,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

  Future<Either<RequestError, T>> patch<T>(
    String path, {
    dynamic data = const {},
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) =>
      fetchResponse(
        dio,
        path,
        FetchType.patch,
        data: data,
        fromJson: fromJson,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

  Future<Either<RequestError, T>> delete<T>(
    String path, {
    dynamic data = const {},
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
    Options? options,
    CancelToken? cancelToken,
  }) =>
      fetchResponse(
        dio,
        path,
        FetchType.delete,
        data: data,
        fromJson: fromJson,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

  Future<Either<RequestError, T>> downloading<T>(
    String path, {
    dynamic data = const {},
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
    Options? options,
    ProgressCallback? onReceiveProgress,
    String? savePath,
  }) =>
      fetchResponse(
        dio,
        path,
        FetchType.downloading,
        data: data,
        fromJson: fromJson,
        queryParameters: queryParameters,
        options: options,
        onReceiveProgress: onReceiveProgress,
        savePath: savePath,
      );
}

Future<Either<RequestError, T>> fetchResponse<T>(
  Dio dio,
  String path,
  FetchType type, {
  T Function(Map<String, dynamic>)? fromJson,
  dynamic data,
  Map<String, dynamic>? queryParameters,
  Options? options,
  CancelToken? cancelToken,
  ProgressCallback? onSendProgress,
  ProgressCallback? onReceiveProgress,
  String? savePath,
}) async {
  Response<dynamic> response;

  dio.options.headers = headers;
  try {
    switch (type) {
      case FetchType.get:
        response = await dio.get(
          path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
        );
        break;
      case FetchType.post:
        response = await dio.post(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        );
        break;
      case FetchType.put:
        response = await dio.put(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        );
        break;
      case FetchType.delete:
        response = await dio.delete(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        );
        break;
      case FetchType.patch:
        response = await dio.patch(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        );
        break;
      case FetchType.downloading:
        response = await dio.download(
          path,
          savePath,
          queryParameters: queryParameters,
          onReceiveProgress: onReceiveProgress,
        );
        break;
    }
  } on DioException catch (error) {
    log.e(error.toString(), error: error.runtimeType);

    if (error.type.isConnectionException) {
      return Left(RequestError.connection(error));
    } else {
      return handleDioException(error);
    }
  }

  final handledResponse = handleResponse(response);

  if (handledResponse.isLeft()) {
    final requestError = handledResponse.swap().toOption().toNullable();

    log.e(
      requestError?.message,
      error: requestError?.runtimeType,
    );
  }

  return parseResponse(
    stackTrace: StackTrace.current,
    response: handledResponse,
    fromJson: fromJson?.call ?? (_) => (Object as T),
  );
}
