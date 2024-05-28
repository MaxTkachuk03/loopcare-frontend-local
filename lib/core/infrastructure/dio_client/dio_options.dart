import 'package:dio/dio.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/injection.dart';

AppConfig appConfig = getIt<AppConfig>();
const String applicationJson = Headers.jsonContentType;
const String contentType = Headers.contentTypeHeader;
const String accept = Headers.acceptHeader;
const String defaultLanguage = "language";
const String region = "region";
const int timeoutDuration = 30000;

Map<String, String> headers = {
  contentType: applicationJson,
  accept: applicationJson,
  // defaultLanguage: "en",
  // region: appConfig.region,
};

final dioOptions = Dio(
  BaseOptions(
    baseUrl: appConfig.baseUrl,
    headers: headers,
    connectTimeout: const Duration(milliseconds: timeoutDuration),
    receiveTimeout: const Duration(milliseconds: timeoutDuration),
    receiveDataWhenStatusError: true,
    followRedirects: true,
    validateStatus: (statusCode) => statusCode == 401 || statusCode == 402 ? false : true,
    contentType: Headers.jsonContentType,
  ),
)..transformer = BackgroundTransformer();
