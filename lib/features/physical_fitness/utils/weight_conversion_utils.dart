class WeightConversionUtils {
  static double kgInLbs = 2.20462262185;
  static double lbsInKg = 0.45359237;

  static double convertKgToLbs(double weight) {
    return double.parse((weight * kgInLbs).toStringAsFixed(2));
  }

  static double convertLbsToKg(double weight) {
    return double.parse((weight * lbsInKg).toStringAsFixed(2));
  }

  WeightConversionUtils._();
}
