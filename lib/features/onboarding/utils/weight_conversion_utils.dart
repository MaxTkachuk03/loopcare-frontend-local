
import 'package:loopcare_frontend/features/onboarding/utils/fixed_value_to.dart';
import 'package:loopcare_frontend/features/onboarding/utils/is_zero_after_decimal.dart';

class WeightConversionUtils {
  static double kgInLbs = 2.20462262185;
  static double lbsInKg = 0.45359237;
  static double gramsInOz = 28.35;

  static num convertKgToLbs(double weight) {
    final fixedValue = fixedValueToOne(weight * kgInLbs);
    return isZeroAfterDecimal(fixedValue) ? fixedValue.toInt() : fixedValue;
  }

  static num convertLbsToKg(double weight) {
    final fixedValue = fixedValueToTwo(weight * lbsInKg);
    return isZeroAfterDecimal(fixedValue) ? fixedValue.toInt() : num.parse(fixedValue.toStringAsFixed(2));
  }

  static num convertOzToGrams(num weight) {
    final fixedValue = fixedValueToTwo(weight * gramsInOz);
    return isZeroAfterDecimal(fixedValue) ? fixedValue.toInt() : fixedValue;
  }

  WeightConversionUtils._();
}
