import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_service.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/account_response.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/email_approve_date_response.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/forgot_password_data.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/login_data.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/login_response.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/sign_up_data.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/sign_up_response.dart';

@Injectable(as: AuthenticationService)
class APIAuthenticationService implements AuthenticationService {
  DioClient client;

  APIAuthenticationService(this.client);

  @override
  Future<Either<RequestError, EmailApproveDateResponse>> emailApproveDate(
      int accountId) async {
    return client
        .get('/accounts/$accountId/emailApproveDate')
        .then(parseResponse(EmailApproveDateResponse.fromJson));
  }

  @override
  Future<Either<RequestError, AccountResponse>> fetchAccount() async {
    return client
        .get('/accounts')
        .then(parseResponse(AccountResponse.fromJson));
  }

  @override
  Future<Either<RequestError, dynamic>> deleteAccount() async {
    return client.delete('/accounts');
  }

  @override
  Future<Either<RequestError, SignUpResponse>> signUp(SignUpData data) async {
    return client
        .post('/accounts/registration', data: data.toJson())
        .then(parseResponse(SignUpResponse.fromJson));
  }

  @override
  Future<Either<RequestError, dynamic>> resendSignUp(int accountId) async {
    return client.post('/accounts/$accountId/resendRegistration', data: {});
  }

  @override
  Future<Either<RequestError, LoginResponse>> login(LoginData data) async {
    return client
        .post('/auth/login', data: data.toJson())
        .then(parseResponse(LoginResponse.fromJson));
  }

  @override
  Future<Either<RequestError, dynamic>> logout() async {
    return client.post('/auth/logout', data: {});
  }

  @override
  Future<Either<RequestError, dynamic>> unlockGrouping() async {
    return client
        .patch('/accounts/unlock-grouping', data: {});
  }

  @override
  Future<Either<RequestError, dynamic>> forgotPassword(
      ForgotPasswordData data) async {
    return client.post('/accounts/forgotPassword', data: data.toJson());
  }
}
