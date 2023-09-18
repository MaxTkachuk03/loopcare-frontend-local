class BmiCalculator {
  static const multiplyIndex = 10000;

  static const metricMultiplyIndex = 10000;
  static const empireMultiplyIndex = 703;

  static num getUserBmiIndex(String? height, String? weight) {
    if (height == null || weight == null) return 0;

    return num.parse(
        ((num.parse(weight) / num.parse(height) / num.parse(height)) * multiplyIndex).toStringAsFixed(1));
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

  BmiCalculator._();
}
