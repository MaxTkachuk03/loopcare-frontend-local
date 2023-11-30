import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
    final token = await _getToken();
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    //Todo remove expired access = 5 min refresh = 15min
    options.headers['access-control-loopcare'] = 'V6lLuQ6cFs0VHNLQrJBazY5-new';
    debugPrint('devcpp REQUEST  PATH: ${options.path}  TOKEN: ${options.headers['Authorization'] ?? ''}');
    return handler.next(options);
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    debugPrint('devcpp RESPONSE  STATUS: ${response.statusCode}  PATH: ${response.realUri.path}');
    if (response.statusCode == HttpStatus.unauthorized) {
      final accessTokenIsUpdated = await authTokenManager.updateAccessToken();
      final refreshTokenIsUpdated = await authTokenManager.updateRefreshToken();
      if (accessTokenIsUpdated && refreshTokenIsUpdated) {
        final token = await _getToken();
        debugPrint('devcpp RESPONSE REFRESH GOT TOKEN:  $token');
        final res = await dioOptions.fetch(response.requestOptions..setAuthenticationHeader(token));
        return handler.resolve(res);
      } else {
        return handler.reject(DioException(requestOptions: response.requestOptions));
      }
    } else {
      return handler.next(response);
    }
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != HttpStatus.unauthorized) {
      return super.onError(err, handler);
    }
    return handler.next(err);
  }

  Future<String> _getToken() async {
    final token = await authTokenManager.getAccessToken();
    return token ?? '';
  }
}

extension _AuthRequestOptionsX on RequestOptions {
  void setAuthenticationHeader(String token) => headers['Authorization'] = 'Bearer $token';

  int get retryAttempt => (extra['auth_retry_attempt'] as int?) ?? 0;

  set retryAttempt(int attempt) => extra['auth_retry_attempt'] = attempt;

  void removeAuthenticationHeader() => headers.remove('Authorization');
}
