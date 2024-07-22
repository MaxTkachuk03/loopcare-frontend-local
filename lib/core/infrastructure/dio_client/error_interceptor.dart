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
    } else {
      return handler.next(response);
    }
  }

  bool _isMaintenance(Response<dynamic> response) => response.statusCode == 503;

  void _pushToMaintenanceScreen() {
    FlutterNativeSplash.remove();
    kOverlayContext.router.replaceAll([const MaintenanceRoute()]);
  }
}
