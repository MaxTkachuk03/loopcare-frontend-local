import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/features/authentication/domain/login_password/login_password_validation_errors.dart';

Either<LoginPasswordValidationErrors, String> validateEmpty(String input) {
  return input.isEmpty
      ? left(const LoginPasswordValidationErrors.empty())
      : right(input);
}
