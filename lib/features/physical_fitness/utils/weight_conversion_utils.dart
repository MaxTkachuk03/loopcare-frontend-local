import 'package:loopcare_frontend/features/physical_fitness/utils/fixed_value_to_one.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/is_zero_after_decimal.dart';

class WeightConversionUtils {
  static double kgInLbs = 2.20462262185;
  static double lbsInKg = 0.45359237;

  static num convertKgToLbs(double weight) {
    final fixedValue = fixedValueToOne(weight * kgInLbs);
    return isZeroAfterDecimal(fixedValue) ? fixedValue.toInt() : fixedValue;
  }

  static num convertLbsToKg(double weight) {
    final fixedValue = fixedValueToOne(weight * lbsInKg);
    return isZeroAfterDecimal(fixedValue) ? fixedValue.toInt() : fixedValue;
  }

  WeightConversionUtils._();
}
