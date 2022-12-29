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

  static SvgPicture checkMarkGreen = SvgPicture.asset(
    '$iconsFilePath/check_mark_green.svg',
    width: 50,
    height: 50,
  );

  AppImages._();
}
