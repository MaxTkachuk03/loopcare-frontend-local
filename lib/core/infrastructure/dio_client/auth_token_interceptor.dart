import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/auth_token_manager.dart';

@injectable
class AuthTokenInterceptor extends Interceptor {
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
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      await authTokenManager.updateAccessToken();
      await authTokenManager.updateRefreshToken();
    }

    handler.next(err);
  }
}
