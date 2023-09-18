import 'package:loopcare_frontend/features/physical_fitness/utils/bmi_calculator.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/height_conversion_utils.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/weight_conversion_utils.dart';
import 'package:test/test.dart';

void main() {
  test('5 ft 9 inches', () {
    const ft = 5;
    const inch = 9;
    const lbs = 272.0;
    const expectedBMI = 40.3;

    var cm = HeightConversionUtils.convertFeetAndInchesToCM(ft, inch);
    var kg = WeightConversionUtils.convertLbsToKg(lbs);

    var result = BmiCalculator.getUserBmiIndex(cm.toString(), kg.toString());

    expect(expectedBMI, result);
  });
}
