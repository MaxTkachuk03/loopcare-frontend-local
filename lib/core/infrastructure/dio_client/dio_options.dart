import 'package:dio/dio.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/injection.dart';

AppConfig appConfig = getIt<AppConfig>();
const String applicationJson = Headers.jsonContentType;
const String contentType = Headers.contentTypeHeader;
const String accept = Headers.acceptHeader;
const String defaultLanguage = "language";

Map<String, String> headers = {
  contentType: applicationJson,
  accept: applicationJson,
  defaultLanguage: "en",
};

final dioOptions = Dio(
  BaseOptions(
    baseUrl: appConfig.baseUrl,
    headers: headers,
    connectTimeout: const Duration(milliseconds: 30000),
    receiveTimeout: const Duration(milliseconds: 5000),
    receiveDataWhenStatusError: true,
    followRedirects: true,
    validateStatus: (statusCode) => true,
    contentType: Headers.jsonContentType,
  ),
)..transformer = BackgroundTransformer();
