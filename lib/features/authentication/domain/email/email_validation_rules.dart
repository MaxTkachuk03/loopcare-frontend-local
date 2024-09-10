import 'package:dartz/dartz.dart';
import 'package:email_validator/email_validator.dart';
import 'package:loopcare_frontend/features/authentication/domain/email/email_validation_errors.dart';

Either<EmailValidationErrors, String> validateEmpty(String input) {
  return input.isEmpty ? left(const EmailValidationErrors.empty()) : right(input);
}

Either<EmailValidationErrors, String> validateEmail(String input) {
  return EmailValidator.validate(input)
      ? right(input)
      : left(const EmailValidationErrors.invalid());
}
