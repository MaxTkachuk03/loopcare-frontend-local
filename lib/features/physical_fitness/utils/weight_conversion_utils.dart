import 'package:loopcare_frontend/features/physical_fitness/utils/fixed_value_to.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/is_zero_after_decimal.dart';

class WeightConversionUtils {
  static double kgInLbs = 2.20462262185;
  static double lbsInKg = 0.45359237;
  static double grammsInOz = 28.35;

  static num convertKgToLbs(double weight) {
    final fixedValue = fixedValueToOne(weight * kgInLbs);
    return isZeroAfterDecimal(fixedValue) ? fixedValue.toInt() : fixedValue;
  }

  static num convertLbsToKg(double weight) {
    final fixedValue = fixedValueToTwo(weight * lbsInKg);
    return isZeroAfterDecimal(fixedValue) ? fixedValue.toInt() : fixedValue;
  }

  static num convertOzToGramms(num weight) {
    final fixedValue = fixedValueToTwo(weight * grammsInOz);
    return isZeroAfterDecimal(fixedValue) ? fixedValue.toInt() : fixedValue;
  }

  WeightConversionUtils._();
}
