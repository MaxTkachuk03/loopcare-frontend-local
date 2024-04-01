import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/features/onboarding_new/domain/height/height_validation_errors.dart';

Either<HeightValidationErrors, String> validateEmpty(String input) {
  return input.isEmpty ? left(const HeightValidationErrors.empty()) : right(input);
}

Either<HeightValidationErrors, String> validateHeightValue(
  String input,
  int maxValue,
  int minValue,
) {
  final intHeight = num.parse(input);

  if (intHeight > maxValue) {
    return left(const HeightValidationErrors.heightTooLarge());
  }

  if (intHeight < minValue) {
    return left(const HeightValidationErrors.heightTooSmall());
  }

  return right(input);
}
