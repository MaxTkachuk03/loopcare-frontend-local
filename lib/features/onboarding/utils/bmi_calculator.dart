class BmiCalculator {
  const BmiCalculator._();

  static const multiplyIndex = 10000;

  static const metricMultiplyIndex = 10000;
  static const empireMultiplyIndex = 703;

  static const lowerLimitBmi = 25.0;
  static const upperYoungLimitBmi = 38.5;
  static const upperOldLimitBmi = 39.9;

  static num getUserBmiIndex(String? height, String? weight) {
    if (height == null || weight == null) return 0;

    return num.parse(((num.parse(weight) / num.parse(height) / num.parse(height)) * multiplyIndex)
        .toStringAsFixed(1));
  }

  static bool validate(num? bmi, int? age) {
    if (bmi == null || age == null) return false;

    if (age <= 19) {
      return bmi >= lowerLimitBmi && bmi <= upperYoungLimitBmi;
    } else {
      return bmi >= lowerLimitBmi && bmi <= upperOldLimitBmi;
    }
  }

// Waiting approving from BA/customers.
/*
  static num getBmiIndex(String? height, String? weight, bool metric) {
    if (height == null || weight == null) return 0;

    return _bmiIndex(height, weight, metric ? metricMultiplyIndex : empireMultiplyIndex);
  }

  static num _bmiIndex(String? height, String? weight, int multiplyIndex) {
    if (height == null || weight == null) return 0;

    return num.parse(
        ((num.parse(weight) / num.parse(height) / num.parse(height)) * multiplyIndex).toStringAsFixed(1));
  }
  */
}
