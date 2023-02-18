import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/auth_token_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Either<RequestError, T>> _process<T>(Future<T> Function() request) =>
    Task(request).attempt().map((e) => e.leftMap(parseRequestError)).run();

@lazySingleton
class DioClient {
  late final Dio dio;

  final AppConfig _appConfig;
  final AuthTokenInterceptor _authTokenInterceptor;
  final SharedPreferences sharedPreferences;

  DioClient(
      this._appConfig, this._authTokenInterceptor, this.sharedPreferences) {
    dio = Dio(
      BaseOptions(
        baseUrl: _appConfig.baseUrl,
        connectTimeout: 5000,
        receiveTimeout: 5000,
      ),
    );

    dio.interceptors.add(_authTokenInterceptor);
    if (const String.fromEnvironment('FLAVOR') == 'dev') {
      dio.httpClientAdapter = _createAdapter();
    }
  }

  HttpClientAdapter _createAdapter() => DefaultHttpClientAdapter()
    ..onHttpClientCreate = (client) => client
      ..findProxy = _findProxy
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

  String _findProxy(Uri url) {
    final ip = sharedPreferences.getString('_ip');
    final port = sharedPreferences.getString('_port');

    bool hasProxy =
        ip != null && ip.isNotEmpty && port != null && port.isNotEmpty;

    return hasProxy ? 'PROXY $ip:$port' : 'DIRECT';
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
    return _process(() => dio.get(
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
    return _process(() => dio.post(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        ));
  }
}
