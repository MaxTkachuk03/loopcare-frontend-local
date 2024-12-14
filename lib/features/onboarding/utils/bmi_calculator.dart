class BmiCalculator {
  const BmiCalculator._();

  static const multiplyIndex = 10000;

  static const metricMultiplyIndex = 10000;
  static const empireMultiplyIndex = 703;

  static const lowerLimitBmi = 18.5;
  static const lowerAcceptableValue = 25.0;
  static const upperAcceptableValue = 39.9;

  static num getUserBmiIndex(String? height, String? weight) {
    if (height == null || weight == null) return 0;

    return num.parse(((num.parse(weight) / num.parse(height) / num.parse(height)) * multiplyIndex)
        .toStringAsFixed(1));
  }

  static bool validate(num? bmi) => bmi != null && bmi >= lowerLimitBmi;
}
