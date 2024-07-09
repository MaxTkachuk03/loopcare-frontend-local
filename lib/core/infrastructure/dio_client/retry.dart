// Dart imports:
import 'dart:async';
import 'dart:io';

// Package imports:
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;

  RetryOnConnectionChangeInterceptor({required this.requestRetrier});

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      try {
        final response = await requestRetrier.scheduleRequestRetry(err.requestOptions);
        handler.resolve(response);
      } catch (_) {}
    } else {
      return handler.next(err);
    }
  }

  bool _shouldRetry(DioException err) {
    final shouldRetry =
        (err.type == DioExceptionType.unknown || err.type == DioExceptionType.connectionError) &&
            err.error != null &&
            err.error is SocketException;
    return shouldRetry;
  }
}

class DioConnectivityRequestRetrier {
  final Dio dio;
  final Connectivity connectivity;

  DioConnectivityRequestRetrier({
    required this.dio,
    required this.connectivity,
  });

  Future<Response<dynamic>> scheduleRequestRetry(
    RequestOptions requestOptions,
  ) async {
    late StreamSubscription<dynamic> streamSubscription;
    final responseCompleter = Completer<Response<dynamic>>();

    streamSubscription = connectivity.onConnectivityChanged.listen(
      (connectivityResult) async {
        if (!connectivityResult.contains(ConnectivityResult.none)) {
          await streamSubscription.cancel();
          // Complete the completer instead of returning
          responseCompleter.complete(
            dio.request(
              requestOptions.path,
              cancelToken: requestOptions.cancelToken,
              data: requestOptions.data,
              options: Options(
                  method: requestOptions.method,
                  headers: requestOptions.headers,
                  sendTimeout: requestOptions.sendTimeout,
                  receiveTimeout: requestOptions.receiveTimeout),
              onReceiveProgress: requestOptions.onReceiveProgress,
              onSendProgress: requestOptions.onSendProgress,
              queryParameters: requestOptions.queryParameters,
            ),
          );
        }
      },
    );

    return responseCompleter.future;
  }
}
