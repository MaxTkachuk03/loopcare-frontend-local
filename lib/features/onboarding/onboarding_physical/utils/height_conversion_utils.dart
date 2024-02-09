class HeightConversionUtils {
  static double footInCm = 0.032808;
  static int inchesInFoot = 12;
  static double inchInCm = 0.393701;
  static double cmInFoot = 30.48;
  static double cmInInch = 2.54;

  static double doubleConvertFeetAndInchesToCM(double foot, double inches) =>
      doubleConvertFTtoCM(foot) + doubleConvertINtoCM(inches);

  static double doubleConvertFTtoCM(double foot) => foot * cmInFoot;

  static double doubleConvertINtoCM(double inches) => inches * cmInInch;

  static double doubleConvertCMtoFT(double lengthInCm) => (lengthInCm / cmInInch ~/ inchesInFoot).toDouble();

  static double doubleConvertFTtoIN(double foot) => foot * inchesInFoot;

  static double doubleConvertCMtoFtIn(double lengthInCm) {
    var foot = doubleConvertCMtoFT(lengthInCm);
    var inches = (lengthInCm / cmInInch) - doubleConvertFTtoIN(foot);
    return inches;
  }

  static int convertINtoFT(int inches) => inches ~/ inchesInFoot;

  static double convertFTtoCM(int foot) => foot * cmInFoot;

  static int convertFTtoIN(int foot) => foot * inchesInFoot;

  static double convertINtoCM(int inches) => inches * cmInInch;

  static int convertFeetAndInchesToCM(int foot, int inches) =>
      (convertFTtoCM(foot) + convertINtoCM(inches)).round();

  HeightConversionUtils._();
}
