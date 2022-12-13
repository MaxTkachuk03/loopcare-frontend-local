import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/auth_token_interceptor.dart';

@lazySingleton
class DioClient {
  late final Dio dio;

  final AppConfig _appConfig;
  final AuthTokenInterceptor _authTokenInterceptor;

  DioClient(this._appConfig, this._authTokenInterceptor) {
    dio = Dio(
      BaseOptions(
        baseUrl: _appConfig.baseUrl,
        connectTimeout: 5000,
        receiveTimeout: 5000,
      ),
    );

    dio.interceptors.add(_authTokenInterceptor);
  }
}
