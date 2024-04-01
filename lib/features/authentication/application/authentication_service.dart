import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/domain/unlock_config/unlock_feature/unlock_feature.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/account_response.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/email_approve_date_response.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/forgot_password_data.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/login_data.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/login_response.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/report_abuse_data.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/sign_up_data.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/sign_up_response.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/unlock_feature_response.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/validate_email_data.dart';

abstract class AuthenticationService {
  Future<Either<RequestError, EmailApproveDateResponse>> emailApproveDate(int accountId);

  Future<Either<RequestError, SignUpResponse>> signUp(SignUpData data);

  Future<Either<RequestError, dynamic>> resendSignUp(int accountId);

  Future<Either<RequestError, AccountResponse>> fetchAccount();

  Future<Either<RequestError, dynamic>> deleteAccount();

  Future<Either<RequestError, LoginResponse>> login(LoginData data);

  Future<Either<RequestError, dynamic>> logout();

  Future<Either<RequestError, UnlockFeatureResponse>> unlockFeature(UnlockFeature feature);

  Future<Either<RequestError, dynamic>> forgotPassword(ForgotPasswordData email);

  Future<Either<RequestError, dynamic>> reportAbuse(ReportAbuseData data);

  Future<Either<RequestError, dynamic>> checkEmail(ValidateEmailData data);
}
