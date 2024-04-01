class BmiValidator {
  static const minValue = 25;
  static const maxValue = 39.9;
  static const percent = 1.4; // 140%
  static const index = 27.5;
  static const minAllowedAge = 19;

  static get maxValueForYoung => percent * index;

  static bool isUserAllowToProceed(num age, num bmiIndex) {
    if (age > minAllowedAge) {
      return minValue <= bmiIndex && bmiIndex <= maxValue;
    }

    return minValue <= bmiIndex && bmiIndex <= maxValueForYoung;
  }

  static String getMaxBmiIndexValue(int age) {
    return age > minAllowedAge ? '$maxValue' : '${percent * index}';
  }

  static String getMinBmiIndexValue() {
    return '$minValue';
  }

  BmiValidator._();
}
