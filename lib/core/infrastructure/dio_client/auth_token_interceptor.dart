import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/auth_token_manager.dart';
import 'package:loopcare_frontend/core/application/dto/updated_access_token_response.dart';
import 'package:loopcare_frontend/core/application/dto/updated_refresh_token_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart' as dioClient;
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_options.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';

import 'parse_response.dart';

@injectable
class AuthTokenInterceptor extends Interceptor {
  AuthTokenManager authTokenManager;

  AuthTokenInterceptor(this.authTokenManager);

  List<Map<dynamic, dynamic>> failedRequests = [];
  bool isRefreshing = false;
  int retries = 1;

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
//    debugPrint('devcpp RESPONSE  STATUS: ${response.statusCode}  PATH: ${response.realUri.path}');
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}, IS REFRESHING: ${isRefreshing.toString()}');
    if (err.response?.statusCode == 401) {
      final token = await _getToken();
      if (token.isEmpty) {
        debugPrint("devcpp LOGGING OUT: NO REFRESH TOKEN FOUND");
        // perform logout
        GetIt.instance<AuthenticationCubit>().logout();
        return handler.reject(err);
      }

      if (!isRefreshing) {
        debugPrint("devcpp ACCESS TOKEN EXPIRED, GETTING NEW TOKEN PAIR");
        isRefreshing = true;
        await refreshToken(err, handler);
      } else {
        debugPrint("devcpp ADDING ERRRORED REQUEST TO FAILED QUEUE");
        failedRequests.add({'err': err, 'handler': handler});
      }
    } else {
      return handler.next(err);
    }
  }

  FutureOr refreshToken(DioException err, ErrorInterceptorHandler handler) async {
    // handle refresh token
    if (err.requestOptions.retryAttempt == retries) {
      debugPrint("devcpp LOGGING OUT: RETRY ATTEMPT FINISHED");
      GetIt.instance<AuthenticationCubit>().logout();
      return handler.reject(err);
    }
    final attempt = err.requestOptions.retryAttempt + 1;
    err.requestOptions.retryAttempt = attempt;

    var isRefreshed = await _refreshToken();
    if (!isRefreshed) {
      // handle logout
      debugPrint("devcpp LOGGING OUT: EXPIRED REFRESH TOKEN");
      GetIt.instance<AuthenticationCubit>().logout();
      return handler.reject(err);
    }

    // handle setting tokens in your store for future requests

    isRefreshing = false;
    failedRequests.add({'err': err, 'handler': handler});
    debugPrint("devcpp RETRYING ${failedRequests.length} FAILED REQUEST(s)");
    final token = await _getToken();
    retryRequests(token);
  }

  Future retryRequests(token) async {
    for (var i = 0; i < failedRequests.length; i++) {
      debugPrint('devcpp RETRYING[$i] => PATH: ${failedRequests[i]['err'].requestOptions.path}');
      RequestOptions requestOptions = failedRequests[i]['err'].requestOptions as RequestOptions;
      requestOptions.headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
      await dioOptions.fetch(requestOptions).then(
            failedRequests[i]['handler'].resolve,
            onError: (error) => failedRequests[i]['handler'].reject(error as DioException),
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
    final request = await dioClient
        .handleProcess(dioOptions.post('/auth/accessToken', data: {'refreshToken': token}))
        .then(parseResponse(UpdatedAccessTokenResponse.fromJson));
    debugPrint('devcpp updateAccessToken: ${request.toString()}');
    request.fold(
      (error) {
        authTokenManager.removeRefreshToken();
        authTokenManager.removeAccessToken();
      },
      (response) {
        authTokenManager.setAccessToken(response.accessToken);
      },
    );
    return request.isRight();
  }

  Future<bool> updateRefreshToken() async {
    final token = await authTokenManager.getRefreshToken();

    if (token == null) return false;

    final request = await dioClient
        .handleProcess(dioOptions.post('/auth/refreshToken', data: {'refreshToken': token}))
        .then(parseResponse(UpdatedRefreshTokenResponse.fromJson));
    debugPrint('devcpp updateRefreshToken: ${request.toString()}');
    request.fold(
      (error) {
        authTokenManager.removeRefreshToken();
        authTokenManager.removeAccessToken();
      },
      (response) {
        authTokenManager.setRefreshToken(response.refreshToken);
      },
    );
    return request.isRight();
  }

  Future<bool> _refreshToken() async {
    final accessTokenIsUpdated = await updateAccessToken();
    final refreshTokenIsUpdated = await updateRefreshToken();
    return accessTokenIsUpdated && refreshTokenIsUpdated;
  }
}

extension _AuthRequestOptionsX on RequestOptions {
  int get retryAttempt => (extra['auth_retry_attempt'] as int?) ?? 0;

  set retryAttempt(int attempt) => extra['auth_retry_attempt'] = attempt;
}
