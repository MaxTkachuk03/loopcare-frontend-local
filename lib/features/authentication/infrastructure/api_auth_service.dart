import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_service.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/account_document_version_data.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/account_response.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/email_approve_date_response.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/forgot_password_data.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/login_data.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/login_response.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/report_abuse_data.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/sign_up_data.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/validate_email_data.dart';

@Injectable(as: AuthenticationService)
class APIAuthenticationService implements AuthenticationService {
  DioClient client;

  APIAuthenticationService(this.client);

  @override
  Future<Either<RequestError, EmailApproveDateResponse>> emailApproveDate(int accountId) async {
    return await client.get('/accounts/$accountId/emailApproveDate',
        fromJson: EmailApproveDateResponse.fromJson);
  }

  @override
  Future<Either<RequestError, AccountResponse>> fetchAccount() async {
    return await client.get('/accounts', fromJson: AccountResponse.fromJson);
  }

  @override
  Future<Either<RequestError, dynamic>> deleteAccount() async {
    return await client.delete('/accounts');
  }

  @override
  Future<Either<RequestError, LoginResponse>> signUp(SignUpData data) async {
    return await client.post('/accounts/registration',
        data: data, fromJson: LoginResponse.fromJson);
  }

  @override
  Future<Either<RequestError, dynamic>> resendSignUp(int accountId) async {
    return await client.post('/accounts/$accountId/resendRegistration');
  }

  @override
  Future<Either<RequestError, LoginResponse>> login(LoginData data) async {
    return await client.post('/auth/login', data: data, fromJson: LoginResponse.fromJson);
  }

  @override
  Future<Either<RequestError, dynamic>> logout() async {
    return await client.post('/auth/logout');
  }

  // @override
  // Future<Either<RequestError, UnlockFeatureResponse>> unlockFeature(UnlockFeature data) async {
  //   return await client.patch(
  //     '/accounts/set-feature',
  //     data: data.toJson(),
  //     fromJson: UnlockFeatureResponse.fromJson,
  //   );
  // }

  @override
  Future<Either<RequestError, dynamic>> forgotPassword(ForgotPasswordData data) async {
    return await client.post('/accounts/forgotPassword', data: data.toJson());
  }

  @override
  Future<Either<RequestError, dynamic>> reportAbuse(ReportAbuseData data) async {
    return await client.post('/accounts/report-issue', data: data.toJson());
  }

  @override
  Future<Either<RequestError, dynamic>> checkEmail(ValidateEmailData data) async {
    return await client.post('/accounts/validate-email', data: data.toJson());
  }

  @override
  Future<Either<RequestError, dynamic>> updateUserEmail(UpdateUserEmailData data) async {
    // TODO update url when back end will be ready
    return await client.post('/accounts/validate-email', data: data.toJson());
  }

  @override
  Future<Either<RequestError, dynamic>> updateDocumentVersion(AccountDocumentVersionData data) {
    return client.patch('/accounts/accept-document-version', data: data.toJson());
  }
}
