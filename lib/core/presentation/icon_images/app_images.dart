import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImages {
  static const String iconsFilePath = 'assets/images';

  static const AssetImage logo = AssetImage('$iconsFilePath/logo.png');
  static const AssetImage introOne = AssetImage('$iconsFilePath/intro_one.png');
  static const AssetImage introTwo = AssetImage('$iconsFilePath/intro_two.png');
  static const AssetImage introThree =
      AssetImage('$iconsFilePath/intro_three.png');
  static const AssetImage coffee = AssetImage('$iconsFilePath/coffee.png');
  static const AssetImage signUpWelcome =
      AssetImage('$iconsFilePath/sign_up_welcome.png');

  static const AssetImage preferencesDiabetes =
      AssetImage('$iconsFilePath/diabetes.png');

  static const AssetImage editButton =
      AssetImage('$iconsFilePath/edit_button.png');

  static const AssetImage youAndFoodIntro =
      AssetImage('$iconsFilePath/you_and_food_intro.png');

  static const AssetImage selfHelpIntro =
      AssetImage('$iconsFilePath/self_help_intro.png');

  static const AssetImage calorieDensityFoodA =
      AssetImage('$iconsFilePath/calorie_dencity_food_a.png');

  static const AssetImage calorieDensityFoodB =
      AssetImage('$iconsFilePath/calorie_dencity_food_b.png');

  static SvgPicture logoSvgBig =
      SvgPicture.asset('$iconsFilePath/logo.svg', width: 114, height: 107);

  static SvgPicture logoSvgMedium =
      SvgPicture.asset('$iconsFilePath/logo.svg', width: 77, height: 71);

  static SvgPicture logoSvgGreenBig = SvgPicture.asset(
    '$iconsFilePath/logo_green.svg',
    width: 114,
    height: 107,
  );

  static SvgPicture checkMarkGreen = SvgPicture.asset(
    '$iconsFilePath/check_mark_green.svg',
    width: 50,
    height: 50,
  );

  static SvgPicture exclamationMark = SvgPicture.asset(
    '$iconsFilePath/exclamation_mark.svg',
    width: 50,
    height: 50,
  );

  static SvgPicture like = SvgPicture.asset(
    '$iconsFilePath/like.svg',
    width: 50,
    height: 50,
  );

  AppImages._();
}
