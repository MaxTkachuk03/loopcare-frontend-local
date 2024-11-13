import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/features/authentication/domain/login_password/login_password_validation_errors.dart';
import 'package:loopcare_frontend/features/authentication/domain/login_password/login_password_validation_rules.dart';

class LoginPassword {
  static Either<LoginPasswordValidationErrors, LoginPassword> create(String string) {
    return validateEmpty(string.trim()).map((String string) => LoginPassword(string));
  }

  final String value;

  const LoginPassword(this.value);
}
