import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/auth_token_interceptor.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_options.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/retry.dart';
import 'package:loopcare_frontend/core/infrastructure/services/network_service/network_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/injection.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

enum DioRequestCancellationReason {
  searchManualCancel,
}

Future<Either<RequestError, T>> process<T>(Future<T> Function() request) {
  return Task(request).attempt().map((e) => e.leftMap(parseRequestError)).run();
}

Future<Either<RequestError, Response<dynamic>>> _handleProcess(
    Future<Either<RequestError, Response<dynamic>>> future) async {
  final bool connected = await getIt<NetworkStatusService>().checkInternetConnection();
  try {
    return future;
  } on DioException catch (e) {
    if (!connected) {
      throw RequestError.connection(e);
    } else {
      throw RequestError.dioOther(e);
    }
  }
}

@lazySingleton
class DioClient {
  late final Dio dio;
  final AuthTokenInterceptor _authTokenInterceptor;
  final SharedStorageService sharedPreferences;

  DioClient(this._authTokenInterceptor, this.sharedPreferences) {
    dio = dioOptions;

    dio.interceptors.add(_authTokenInterceptor);
    _configureRetryConnection();

    if (dotenv.env['NEED_DIO_LOGGER'] == 'true') {
      dio.interceptors.add(PrettyDioLogger(
          requestHeader: false, requestBody: false, responseHeader: false, responseBody: false));
    }

    if (const String.fromEnvironment('FLAVOR') == 'dev') {
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
    return _handleProcess(
      process(
        () => dio.get(
          path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
        ),
      ),
    );
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
    return _handleProcess(
      process(
        () => dio.post(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        ),
      ),
    );
  }

  Future<Either<RequestError, Response<dynamic>>> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    String? baseUrl,
    CancelToken? cancelToken,
  }) async {
    return _handleProcess(
      process(
        () => dio.delete(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ),
      ),
    );
  }

  Future<Either<RequestError, Response<dynamic>>> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    String? baseUrl,
    CancelToken? cancelToken,
  }) async {
    return _handleProcess(
      process(
        () => dio.patch(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ),
      ),
    );
  }

  Future<Either<RequestError, Response<dynamic>>> downloading(
    String path,
    String savePath, {
    Map<String, dynamic>? queryParameters,
    bool withInterceptor = true,
    bool withRetryInterceptor = false,
  }) async {
    return _handleProcess(
      process(
        () => dio.download(
          path,
          savePath,
          queryParameters: queryParameters,
        ),
      ),
    );
  }
}
