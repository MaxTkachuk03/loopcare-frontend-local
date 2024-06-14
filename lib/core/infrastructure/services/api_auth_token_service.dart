import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/auth_token_service.dart';
import 'package:loopcare_frontend/core/application/dto/updated_access_token_response.dart';
import 'package:loopcare_frontend/core/application/dto/updated_refresh_token_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_options.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';

@Injectable(as: AuthTokenService)
class APIAuthTokenService implements AuthTokenService {
  late final Dio dio;

  APIAuthTokenService() {
    dio = dioOptions;
  }

  @override
  Future<Either<RequestError, UpdatedAccessTokenResponse>> updateAccessToken(String token) async {
    return await fetchResponse(
      dio,
      '/auth/accessToken',
      FetchType.post,
      data: {'refreshToken': token},
      fromJson: (r) => UpdatedAccessTokenResponse.fromJson(r),
    );
  }

  @override
  Future<Either<RequestError, UpdatedRefreshTokenResponse>> updateRefreshToken(String token) async {
    return await fetchResponse(
      dio,
      '/auth/refreshToken',
      FetchType.post,
      data: {'refreshToken': token},
      fromJson: (r) => UpdatedRefreshTokenResponse.fromJson(r),
    );
  }
}
