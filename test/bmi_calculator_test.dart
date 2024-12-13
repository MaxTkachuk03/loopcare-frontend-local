import 'package:flutter_test/flutter_test.dart';
import 'package:loopcare_frontend/features/onboarding/utils/bmi_calculator.dart';
import 'package:loopcare_frontend/features/onboarding/utils/height_conversion_utils.dart';
import 'package:loopcare_frontend/features/onboarding/utils/weight_conversion_utils.dart';

void main() {
  test('5 ft 9 inches', () {
    const ft = 5.0;
    const inch = 9.0;
    const lbs = 272.0;
    const expectedBMI = 40.3;

    var cm = HeightConversionUtils.doubleConvertFeetAndInchesToCM(ft, inch);
    var kg = WeightConversionUtils.convertLbsToKg(lbs);

    var result = BmiCalculator.getUserBmiIndex(cm.toString(), kg.toString());

    expect(expectedBMI, result);
  });
}
