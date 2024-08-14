import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';

@injectable
class ErrorInterceptor extends QueuedInterceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (_isMaintenance(response)) {
      _pushToMaintenanceScreen();
    } else if (_isPaymentRequired(response)) {
      _pushToSubscriptionScreen();
    } else {
      return handler.next(response);
    }
  }


  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.type.isConnectionException) {
      return handler.reject(err);
    }

    return handler.next(err);
  }

  bool _isMaintenance(Response<dynamic> response) => response.statusCode == HttpStatus.serviceUnavailable;

  bool _isPaymentRequired(Response<dynamic> response) => response.statusCode == HttpStatus.paymentRequired;

  void _pushToMaintenanceScreen() {
    FlutterNativeSplash.remove();
    kOverlayContext.router.replaceAll([const MaintenanceRoute()]);
  }
  void _pushToSubscriptionScreen() {
    FlutterNativeSplash.remove();
    kOverlayContext.router.replaceAll([const SubscriptionRoute()]);
  }
}

extension ConnectionDioExceptionType on DioExceptionType {
  bool get isConnectionException =>
      this == DioExceptionType.sendTimeout ||
          this == DioExceptionType.connectionTimeout ||
          this == DioExceptionType.connectionError ||
          this == DioExceptionType.receiveTimeout ||
          this == DioExceptionType.unknown;
}