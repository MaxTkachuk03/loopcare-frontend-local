import 'package:dio/dio.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/injection.dart';

AppConfig appConfig = getIt<AppConfig>();

final dioOptions = Dio(
  BaseOptions(
    baseUrl: appConfig.baseUrl,
    connectTimeout: 5000,
    receiveTimeout: 5000,
  ),
);