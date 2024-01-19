import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/domain/height/height_validation_errors.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/domain/height/height_validation_rules.dart';

class Height {
  static const int maxLengthMetric = 3;
  static const int maxLengthImperial = 2;
  static const int minValue = 52;
  static const int maxValue = 250;

  static Either<HeightValidationErrors, Height> create(String string) {
    return validateEmpty(string.trim())
        .flatMap(((v) => validateHeightValue(v, maxValue, minValue)))
        .map((String string) => Height._(string));
  }

  final String value;

  const Height._(this.value);
}
