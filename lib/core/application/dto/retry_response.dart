import 'package:dio/dio.dart';

class RetryResponse {
  final RequestOptions requestOptions;
  final ResponseInterceptorHandler handler;

  RetryResponse({required this.requestOptions, required this.handler});
}
