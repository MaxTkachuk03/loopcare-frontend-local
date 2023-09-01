import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/domain/aws_cookies_type.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/application/dto/aws_cookies_response.dart';

abstract class AwsService {
  Future<Either<RequestError, AwsCookiesResponse>> getAwsCookies(AwsCookiesType type);
}
