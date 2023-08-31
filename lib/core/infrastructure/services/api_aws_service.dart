import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/aws_service.dart';
import 'package:loopcare_frontend/core/application/dto/aws_cookies_response.dart';
import 'package:loopcare_frontend/core/domain/aws_cookies_type.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';

@Injectable(as: AwsService)
class APIAwsService implements AwsService {
  DioClient client;

  APIAwsService(this.client);

  @override
  Future<Either<RequestError, AwsCookiesResponse>> getAwsCookies(AwsCookiesType type) {
    return client.get(
      '/video/cookies',
      queryParameters: {"type": type.name},
    ).then(parseResponse(AwsCookiesResponse.fromJson));
  }
}
