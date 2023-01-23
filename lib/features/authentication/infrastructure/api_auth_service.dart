import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_service.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/sign_up_data.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/sign_up_response.dart';

@Injectable(as: AuthenticationService)
class APIAuthenticationService implements AuthenticationService {
  DioClient client;

  APIAuthenticationService(this.client);

  @override
  Future<Either<RequestError, SignUpResponse>> signUp(SignUpData data) async {
    return client.dio
        .post('/users/registration', data: data.toJson())
        .then(parseResponse(SignUpResponse.fromJson));
  }
}
