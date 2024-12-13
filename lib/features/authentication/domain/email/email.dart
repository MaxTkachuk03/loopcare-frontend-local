import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/features/authentication/domain/email/email_validation_errors.dart';
import 'package:loopcare_frontend/features/authentication/domain/email/email_validation_rules.dart';

class Email {
  static Either<EmailValidationErrors, Email> create(String string) {
    return validateEmpty(string).flatMap(validateEmail).map((String string) => Email(string));
  }

  final String value;

  const Email(this.value);
}
