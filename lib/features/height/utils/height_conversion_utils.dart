class HeightConversionUtils {
  static double cmInFoot = 0.032808;
  static double cmInInch = 0.393701;
  static double footInCM = 30.48;
  static double inchInCM = 2.54;

  static int convertCMtoFeet(double lengthInCm) {
    return (lengthInCm * cmInFoot).toInt();
  }

  static double convertCMtoInches(double lengthInCm) {
    final value = lengthInCm * cmInInch - 12 * convertCMtoFeet(lengthInCm);
    return double.parse((value).toStringAsFixed(2));
  }

  static int convertFeetAndInchesToCM(double feet, double inches) {
    return (feet * footInCM + inches * inchInCM).round();
  }

  HeightConversionUtils._();
}
