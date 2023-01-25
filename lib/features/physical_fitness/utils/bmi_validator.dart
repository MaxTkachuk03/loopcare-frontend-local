class BmiValidator {
  static const minValue = 25;
  static const maxValue = 42;
  static const percent = 1.4; // 140%
  static const index = 27.5;
  static const minAllowedAge = 19;

  static bool isUserAllowToProceed(num age, bmiIndex) {
    if (age > minAllowedAge) {
      return minValue <= bmiIndex && bmiIndex <= maxValue;
    }

    return minValue <= bmiIndex && bmiIndex <= (percent * index);
  }

  BmiValidator._();
}
