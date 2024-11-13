import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/application/dto/updated_access_token_response.dart';
import 'package:loopcare_frontend/core/application/dto/updated_refresh_token_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';

abstract class AuthTokenService {
  Future<Either<RequestError, UpdatedAccessTokenResponse>> updateAccessToken(String token);

  Future<Either<RequestError, UpdatedRefreshTokenResponse>> updateRefreshToken(String token);
}
