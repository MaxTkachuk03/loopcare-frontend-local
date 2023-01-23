import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/sign_up_data.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/sign_up_response.dart';

abstract class AuthenticationService {
  Future<Either<RequestError, SignUpResponse>> signUp(SignUpData data);
}
