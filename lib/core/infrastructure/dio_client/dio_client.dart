import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/auth_token_interceptor.dart';

Future<Either<RequestError, T>> _process<T>(Future<T> Function() request) =>
    Task(request).attempt().map((e) => e.leftMap(parseRequestError)).run();

@lazySingleton
class DioClient {
  late final Dio dio;

  final AppConfig _appConfig;
  final AuthTokenInterceptor _authTokenInterceptor;

  DioClient(this._appConfig, this._authTokenInterceptor) {
    dio = Dio(
      BaseOptions(
        baseUrl: _appConfig.baseUrl,
        connectTimeout: 5000,
        receiveTimeout: 5000,
      ),
    );

    dio.interceptors.add(_authTokenInterceptor);
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
