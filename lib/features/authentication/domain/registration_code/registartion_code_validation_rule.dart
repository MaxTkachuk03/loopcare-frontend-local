import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loopcare_frontend/features/authentication/domain/registration_code/registration_code_validation_errors.dart';

Either<RegistrationCodeValidationErrors, String> validateCodeEmpty(String input) {
  return input.isEmpty ? left(const RegistrationCodeValidationErrors.empty()) : right(input);
}

Either<RegistrationCodeValidationErrors, String> validateCode(String input) {
  return dotenv.env['REGISTRATION_CODE'] == input
      ? right(input)
      : left(const RegistrationCodeValidationErrors.invalid());
}
