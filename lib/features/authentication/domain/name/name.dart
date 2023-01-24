import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/features/authentication/domain/name/name_validation_errors.dart';
import 'package:loopcare_frontend/features/authentication/domain/name/name_validation_rules.dart';

class Name {
  static Either<NameValidationErrors, Name> create(String string) {
    return validateEmpty(string.trim()).map((String string) => Name(string));
  }

  final String value;

  const Name(this.value);
}
