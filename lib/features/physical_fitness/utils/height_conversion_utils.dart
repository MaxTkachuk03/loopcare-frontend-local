class HeightConversionUtils {
  static double footInCm = 0.032808;
  static int inchesInFoot = 12;
  static double inchInCm = 0.393701;
  static double cmInFoot = 30.48;
  static double cmInInch = 2.54;

  static int convertCMtoFT(int lengthInCm) =>
      lengthInCm.floor() / cmInInch ~/ inchesInFoot;

  static double convertCMtoIN(int lengthInCm) => lengthInCm.floor() * inchInCm;

  static int convertCMtoFtIn(int lengthInCm) {
    var foot = convertCMtoFT(lengthInCm);
    var inches = (lengthInCm / cmInInch).floor() - convertFTtoIN(foot);

    return inches;
  }

  static int convertINtoFT(int inches) => inches ~/ inchesInFoot;

  static double convertFTtoCM(int foot) => foot * cmInFoot;

  static int convertFTtoIN(int foot) => foot * inchesInFoot;

  static double convertINtoCM(int inches) => inches * cmInInch;

  static int convertFeetAndInchesToCM(int foot, int inches) =>
      (convertFTtoCM(foot) + convertINtoCM(inches)).ceil();

  HeightConversionUtils._();
}
