import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/auth_token_manager.dart';
import 'package:loopcare_frontend/core/application/dto/retry_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_options.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/server_error_data.dart';

@injectable
class AuthTokenInterceptor extends QueuedInterceptorsWrapper {
  AuthTokenManager authTokenManager;

  final List<RetryResponse> _repeatList = [];
  final List<Future<void> Function()?> _repeatListHandlers = [];
  final int retries = 3;

  AuthTokenInterceptor(this.authTokenManager);

  @override
  Future<void> onRequest(RequestOptions options,
      RequestInterceptorHandler handler,) async {
    final token = await _getToken();
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    //Todo remove expired access = 5 min refresh = 15min
    options.headers['access-control-loopcare'] = 'V6lLuQ6cFs0VHNLQrJBazY5-new';
    return handler.next(options);
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode == HttpStatus.unauthorized) {
      final accessTokenIsUpdated = await authTokenManager.updateAccessToken();
      final refreshTokenIsUpdated = await authTokenManager.updateRefreshToken();
      if (accessTokenIsUpdated && refreshTokenIsUpdated) {
        final token = await _getToken();
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
    a
  }

  void addRepeatResponses(RetryResponse response) {
    _repeatList.add(response);
  }

  Future<void> _composeRepeatRequests() async {
    for (final response in _repeatList) {
      _repeatListHandlers.add(() => _resolveResponse(response));
    }
    return _repeatRequests();
  }

  Future<String> _getToken() async {
    final token = await authTokenManager.getAccessToken();
    return token ?? '';
  }

  Future _resolveResponse(RetryResponse retry) async {
    final token = await _getToken();
    final response = await dioOptions.fetch(retry.requestOptions..setAuthenticationHeader(token));
    return retry.handler.next(response);
  }

  Future<void> _repeatRequests() async {
    for (final response in _repeatListHandlers) {
      try {
        response?.call();
      } on DioException catch (e) {
        if (e.response?.statusCode == HttpStatus.unauthorized) {
          response?.call();
        }
      }
    }
    _repeatListHandlers.clear();
    _repeatList.clear();
  }
}

extension _AuthRequestOptionsX on RequestOptions {
  void setAuthenticationHeader(String token) => headers['Authorization'] = 'Bearer $token';

  int get retryAttempt => (extra['auth_retry_attempt'] as int?) ?? 0;

  set retryAttempt(int attempt) => extra['auth_retry_attempt'] = attempt;

  void removeAuthenticationHeader() => headers.remove('Authorization');
}
