import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/domain/user/user.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/email_approve_date_response.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/forgot_password_data.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/forgot_password_response.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/login_data.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/login_response.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/sign_up_data.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/sign_up_response.dart';

abstract class AuthenticationService {
  Future<Either<RequestError, EmailApproveDateResponse>> emailApproveDate(int userId);

  Future<Either<RequestError, SignUpResponse>> signUp(SignUpData data);

  Future<Either<RequestError, dynamic>> resendSignUp(int userId);

  Future<Either<RequestError, LoginResponse>> login(LoginData data);

  Future<Either<RequestError, dynamic>> logout();

  Future<Either<RequestError, dynamic>> forgotPassword(
      ForgotPasswordData email);
}
