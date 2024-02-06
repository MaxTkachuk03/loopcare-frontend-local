import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/features/authentication/domain/registration_code/registartion_code_validation_rule.dart';
import 'package:loopcare_frontend/features/authentication/domain/registration_code/registration_code_validation_errors.dart';

class RegistrationCode {
  static Either<RegistrationCodeValidationErrors, RegistrationCode> create(String code) {
    return validateCodeEmpty(code).flatMap(validateCode).map((String string) => RegistrationCode(string));
  }

  final String value;

  const RegistrationCode(this.value);
}
