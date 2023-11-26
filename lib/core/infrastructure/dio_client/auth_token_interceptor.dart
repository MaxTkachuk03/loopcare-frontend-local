import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/auth_token_manager.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_options.dart';

@injectable
class AuthTokenInterceptor extends InterceptorsWrapper {
  // Dio dio;
  AuthTokenManager authTokenManager;

  AuthTokenInterceptor(this.authTokenManager);
  // AuthTokenInterceptor(this.dio, this.authTokenManager);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await authTokenManager.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    // TODO will be used to restrict test users access to the app after testing period
    // options.headers["MVP_ACCESS_HEADER_NAME"] = 'access-control-loopcare';
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != HttpStatus.unauthorized) {
      return handler.next(err);
    }
    // dio.interceptors.requestLock.lock();
    // dio.interceptors.responseLock.lock();
    try {
      final accessTokenIsUpdated = await authTokenManager.updateAccessToken();
      final refreshTokenIsUpdated = await authTokenManager.updateRefreshToken();

      if (accessTokenIsUpdated && refreshTokenIsUpdated) {
        return _createUpdatedRequest(err.requestOptions);
      } else {
        // _unlockDio();
        return handler.next(err);
      }
    } catch (e) {
      // _unlockDio();
      return handler.next(err);
    }
  }

  // void _unlockDio() {
  //   dio.interceptors.requestLock.unlock();
  //   dio.interceptors.responseLock.unlock();
  // }

  Future _createUpdatedRequest(RequestOptions request) async {
    final token = await authTokenManager.getAccessToken();
    final dioBaseOption = dioOptions;

    // _unlockDio();

    return dioBaseOption.request(
      request.path,
      cancelToken: request.cancelToken,
      data: request.data,
      onReceiveProgress: request.onReceiveProgress,
      onSendProgress: request.onSendProgress,
      queryParameters: request.queryParameters,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}
