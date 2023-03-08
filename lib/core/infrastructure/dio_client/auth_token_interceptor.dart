import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/auth_token_manager.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_options.dart';

@injectable
class AuthTokenInterceptor extends InterceptorsWrapper {
  AuthTokenManager authTokenManager;

  AuthTokenInterceptor(this.authTokenManager);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await authTokenManager.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != HttpStatus.unauthorized) {
      return handler.next(err);
    }
    try {
      final accessTokenIsUpdated = await authTokenManager.updateAccessToken();
      final refreshTokenIsUpdated = await authTokenManager.updateRefreshToken();

      if (accessTokenIsUpdated && refreshTokenIsUpdated) {
        return _createUpdatedRequest(err.requestOptions);
      } else {
        return handler.next(err);
      }
    } catch (e) {
      return handler.next(err);
    }
  }

  Future _createUpdatedRequest(RequestOptions request) async {
    final token = await authTokenManager.getAccessToken();
    final dio = dioOptions;

    return dio.request(
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
