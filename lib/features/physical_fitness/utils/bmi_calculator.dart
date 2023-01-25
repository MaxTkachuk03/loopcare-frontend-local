class BmiCalculator {
  static const multiplyIndex = 10000;

  static num getUserBmiIndex(String? height, String? weight) {
    if (height == null || weight == null) return 0;

    return ((num.parse(weight) / num.parse(height) / num.parse(height)) *
            multiplyIndex)
        .round();
  }

  BmiCalculator._();
}
