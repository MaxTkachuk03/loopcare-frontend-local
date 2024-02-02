part of 'themes.dart';

class ButtonStyles {
  ButtonStyles._();

  static const Size primarySize = Size(0, ThemeConstants.buttonHeight);
  static const Size fullWidthSize = Size(double.infinity, ThemeConstants.buttonHeight);
  static const Size smallSize = Size(0, ThemeConstants.buttonSmallHeight);

  static const TextStyle primaryLabel = TextStyle(fontSize: ThemeConstants.fontSize14, fontWeight: FontWeight.w600);
  static const TextStyle fullWidthLabel = TextStyle(fontSize: ThemeConstants.fontSize16, fontWeight: FontWeight.w600);

  static const TextStyle outlinedLabel = TextStyle(fontSize: ThemeConstants.fontSize14, fontWeight: FontWeight.w400);

  static const BorderSide borderCoral =
      BorderSide(width: ThemeConstants.outlinedButtonBorderWidth, color: AppColors.coralRegular);

  static const BorderSide borderOrange =
      BorderSide(width: ThemeConstants.outlinedButtonBorderWidth, color: AppColors.orangeRegular);

  static const BorderSide borderYellow =
      BorderSide(width: ThemeConstants.outlinedButtonBorderWidth, color: AppColors.yellowRegular);

  static const BorderSide borderGreen =
      BorderSide(width: ThemeConstants.outlinedButtonBorderWidth, color: AppColors.greenRegular);

  static const BorderSide borderPetrol =
      BorderSide(width: ThemeConstants.outlinedButtonBorderWidth, color: AppColors.petrolRegular);

  static const BorderSide borderBlue =
      BorderSide(width: ThemeConstants.outlinedButtonBorderWidth, color: AppColors.blueRegular);

  static const BorderSide borderDisabled =
      BorderSide(width: ThemeConstants.outlinedButtonBorderWidth, color: AppColors.greyLight);

  static getButtonBorder(defaultBorder) {
    return MaterialStateProperty.resolveWith<BorderSide?>(
      (Set<MaterialState> states) =>
          states.contains(MaterialState.disabled) ? ButtonStyles.borderDisabled : defaultBorder,
    );
  }
}
