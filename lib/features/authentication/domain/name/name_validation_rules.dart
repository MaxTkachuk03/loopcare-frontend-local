import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/features/authentication/domain/name/name_validation_errors.dart';

Either<NameValidationErrors, String> validateEmpty(String input) {
  return input.isEmpty
      ? left(const NameValidationErrors.empty())
      : right(input);
}
