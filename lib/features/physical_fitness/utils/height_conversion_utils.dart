import 'package:loopcare_frontend/features/physical_fitness/utils/fixed_value_to_one.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/is_zero_after_decimal.dart';

class HeightConversionUtils {
  static double cmInFoot = 0.032808;
  static double cmInInch = 0.393701;
  static double footInCM = 30.48;
  static double inchInCM = 2.54;

  static int convertCMtoFeet(num lengthInCm) {
    return (lengthInCm * cmInFoot).toInt();
  }

  static int convertCMtoInches(num lengthInCm) {
    return (lengthInCm * cmInInch - 12 * convertCMtoFeet(lengthInCm)).toInt();
  }

  static num convertFeetAndInchesToCM(double feet, double inches) {
    final value = (feet * footInCM + inches * inchInCM);
    final fixedValue = fixedValueToOne(value);

    return isZeroAfterDecimal(fixedValue) ? fixedValue.toInt() : fixedValue;
  }

  HeightConversionUtils._();
}
