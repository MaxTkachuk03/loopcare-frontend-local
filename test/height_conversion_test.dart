import 'package:flutter_test/flutter_test.dart';
import 'package:loopcare_frontend/features/onboarding/utils/height_conversion_utils.dart';

void main() {
  String doubleConvertImperialToMetric(double heightFT, double heightIN) {
    var heightInCm = HeightConversionUtils.doubleConvertFeetAndInchesToCM(heightFT, heightIN);

    var heightFTret = HeightConversionUtils.doubleConvertCMtoFT(heightInCm);
    var heightINret = HeightConversionUtils.doubleConvertCMtoFtIn(heightInCm);

    return "$heightFTret $heightINret";
  }

  num doubleConvertMetricToImperial(double heightInCm) {
    var heightFT = HeightConversionUtils.doubleConvertCMtoFT(heightInCm);
    var heightIN = HeightConversionUtils.doubleConvertCMtoFtIn(heightInCm);

    var heightInCmRet = HeightConversionUtils.doubleConvertFeetAndInchesToCM(heightFT, heightIN);

    return heightInCmRet;
  }

  test('Test 5 4 Double', () {
    double foot = 5;
    double inch = 4;
    var result = doubleConvertImperialToMetric(foot, inch);
    expect("$foot $inch", result);
  });

  test('Test 163 double', () {
    double startHeight = 162.56;
    var result = doubleConvertMetricToImperial(startHeight);
    var val1 = startHeight.round();
    var val2 = result.round();

    expect(val1, val2);
  });

  test('Test 163', () {
    double startHeight = 163;
    var result = doubleConvertMetricToImperial(startHeight);
    expect(startHeight, result);
  });
}
