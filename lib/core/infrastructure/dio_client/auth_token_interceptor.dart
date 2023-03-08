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
    // final token = await authTokenManager.getToken();
    final token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjkyLCJpYXQiOjE2NzgyNzkyMzMsImV4cCI6MTY3ODM2NTYzM30.4teQhbnXwXNqtvzM3Bzg6Kx4lv9I4jilLQG7Hwqobo8';
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      await authTokenManager.removeToken();
    }
    handler.next(err);
  }
}
