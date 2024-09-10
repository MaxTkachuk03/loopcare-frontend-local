import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/auth_token_manager.dart';
import 'package:loopcare_frontend/core/application/dto/updated_access_token_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_options.dart';
import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';
import 'package:loopcare_frontend/core/infrastructure/services/socket_service/socket_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/socket_service_buddy/buddy_socket_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/socket_service_chat/chat_socket_service.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';

@injectable
class AuthTokenInterceptor extends Interceptor {
  AuthTokenManager authTokenManager;

  AuthTokenInterceptor(this.authTokenManager);

  List<Map<dynamic, dynamic>> failedRequests = [];

  AuthenticationBloc? get _authenticationBloc => GetIt.instance<AuthenticationBloc>();
  bool isRefreshing = false;
  int retries = 3;

  List<Map<dynamic, dynamic>> unique(List<Map<dynamic, dynamic>> list) {
    final paths =
        list.map<String>((e) => (e['err'].requestOptions as RequestOptions).uri.toString()).toSet();
    list.retainWhere((Map x) {
      return paths.remove((x['err'].requestOptions as RequestOptions).uri.toString());
    });
    return list;
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _getToken();
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    log.i(
      'RESPONSE STATUS: ${response.statusCode} PATH: ${response.realUri.path}',
      error: runtimeType,
    );
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    log.e(
      'RESPONSE STATUS: ${err.response?.statusCode} PATH: ${err.requestOptions.path} ERROR${err.response?.data}',
      error: runtimeType,
    );

    if (err.response?.statusCode == 401) {
      log.i(
        'ATTEMPT: ${err.requestOptions.retryAttempt}',
        error: runtimeType,
      );

      if (err.requestOptions.retryAttempt == retries) {
        log.i(
          'LOGGING OUT: ATTEMPTS finished',
          error: runtimeType,
        );

        _clearBeforeLogout();
        return handler.resolve(err.response!);
      }
      final token = await _getToken();
      if (token.isEmpty) {
        log.w('LOGGING OUT: NO REFRESH TOKEN FOUND', error: runtimeType);

        _clearBeforeLogout();
        return handler.reject(err);
      }
      final attempt = err.requestOptions.retryAttempt + 1;
      err.requestOptions.retryAttempt = attempt;
      if (!isRefreshing) {
        log.i(
          'ACCESS TOKEN EXPIRED, GETTING NEW TOKEN PAIR',
          error: runtimeType,
        );

        isRefreshing = true;
        await refreshToken(err, handler);
      } else {
        log.e('ADDING TO FAILED QUEUE => URI: ${err.requestOptions.uri}', error: runtimeType);

        failedRequests.add({'err': err, 'handler': handler});
        failedRequests = unique(failedRequests);
      }
    } else {
      return handler.next(err);
    }
  }

  void _clearBeforeLogout() {
    isRefreshing = false;
    failedRequests = [];
    _authenticationBloc?.add(const AuthenticationEvent.logout());
  }

  FutureOr refreshToken(DioException err, ErrorInterceptorHandler handler) async {
    var refreshed = await _refreshToken();
    if (!refreshed) {
      log.w('LOGGING OUT: EXPIRED REFRESH TOKEN', error: runtimeType);

      _clearBeforeLogout();
      return handler.reject(err);
    }
    log.i(
      'ADDING TO QUEUE => URI: ${err.requestOptions.uri}',
      error: runtimeType,
    );

    isRefreshing = false;
    failedRequests.add({'err': err, 'handler': handler});
    failedRequests = unique(failedRequests);

    log.w('RETRYING ${failedRequests.length} FAILED REQUEST(s)', error: runtimeType);

    final token = await _getToken();
    retryRequests(token);
  }

  Future retryRequests(token) async {
    for (var i = 0; i < failedRequests.length; i++) {
      RequestOptions requestOptions = failedRequests[i]['err'].requestOptions as RequestOptions;

      log.i(
        'RETRYING [$i] => Uri: ${requestOptions.uri}',
        error: runtimeType,
      );

      requestOptions.headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      await dioOptions.fetch(requestOptions).then(
        failedRequests[i]['handler'].resolve,
        onError: (error) {
          return failedRequests[i]['handler'].reject(error as DioException);
        },
      );
    }
    isRefreshing = false;
    failedRequests = [];
  }

  Future<String> _getToken() async {
    final token = await authTokenManager.getAccessToken();
    return token ?? '';
  }

  Future<bool> updateAccessToken() async {
    final token = await authTokenManager.getRefreshToken();
    if (token == null) return false;
    final request = await fetchResponse(
      dioOptions,
      '/auth/accessToken',
      FetchType.post,
      data: {'refreshToken': token},
      fromJson: (r) => UpdatedAccessTokenResponse.fromJson(r),
    );
    request.fold(
      (error) {
        _clearBeforeLogout();
      },
      (response) {
        authTokenManager.setAccessToken(response.accessToken);
      },
    );
    return request.isRight();
  }

  Future<bool> _refreshToken() async {
    final accessTokenIsUpdated = await updateAccessToken();
    if (accessTokenIsUpdated) {
      SocketService.instance.reconnect();
      BuddySocketService.instance.reconnect();
      ChatSocketService.instance.reconnect();
    }
    return accessTokenIsUpdated;
  }
}

extension _AuthRequestOptionsX on RequestOptions {
  int get retryAttempt => (extra['auth_retry_attempt'] as int?) ?? 0;

  set retryAttempt(int attempt) => extra['auth_retry_attempt'] = attempt;
}
