import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class AppImages {
  static const String imagesFilePath = 'assets/images';

  static const AssetImage iconAttention = AssetImage('$imagesFilePath/attention.png');

  static const AssetImage recipePlaceholder = AssetImage('$imagesFilePath/recipe_placeholder.png');

  static const AssetImage sessionPlaceholder = AssetImage('$imagesFilePath/session_placeholder.png');

  static SvgPicture exclamationMark =
      SvgPicture.asset('$imagesFilePath/exclamation_mark.svg', fit: BoxFit.scaleDown);

  static const AssetImage intro = AssetImage('$imagesFilePath/new_intro.png');

  static const AssetImage intro2 = AssetImage('$imagesFilePath/new_intro2.png');

  static const AssetImage physicalIntro = AssetImage('$imagesFilePath/new_physical_intro.png');

  static const AssetImage medicalIntro = AssetImage('$imagesFilePath/new_medical_intro.png');

  static const AssetImage mentalIntro = AssetImage('$imagesFilePath/new_mental_intro.png');

  static const AssetImage welcome = AssetImage('$imagesFilePath/new_welcome.png');

  static SvgPicture oepsBig = SvgPicture.asset('$imagesFilePath/oeps.svg', width: 120, height: 120);

  static SvgPicture oepsSmall = SvgPicture.asset('$imagesFilePath/oeps.svg', width: 60, height: 60);

  static SvgPicture noConnectionBig =
      SvgPicture.asset('$imagesFilePath/no_connection.svg', width: 120, height: 120);

  static SvgPicture noConnectionSmall =
      SvgPicture.asset('$imagesFilePath/no_connection.svg', width: 60, height: 60);

  static SvgPicture calorieDensityFoodA = SvgPicture.asset('$imagesFilePath/calorie_dencity_food_a.svg');

  static SvgPicture calorieDensityFoodB = SvgPicture.asset('$imagesFilePath/calorie_dencity_food_b.svg');

  static SvgPicture bottomFrame = SvgPicture.asset('$imagesFilePath/bottom_frame.svg',
      colorFilter: const ColorFilter.mode(AppColors.blueOffRegular, BlendMode.modulate));

  static const AssetImage educationPreview = AssetImage('$imagesFilePath/new_education_preview.png');

  static const AssetImage educationLessonTest = AssetImage('$imagesFilePath/new_education_lesson_test.png');

  static SvgPicture subscriptionTrialSVG = SvgPicture.asset('$imagesFilePath/subscription_trial.svg');
  static SvgPicture subscriptionCancelledSVG = SvgPicture.asset(
    '$imagesFilePath/subscription_trial.svg',
  );
  static SvgPicture trialClipperSVG = SvgPicture.asset('$imagesFilePath/trial_clipper.svg');
  static SvgPicture cancelledClipperSVG = SvgPicture.asset('$imagesFilePath/cancelled_clipper.svg');
  static const AssetImage trial = AssetImage('$imagesFilePath/trial.png');
  static const AssetImage ended = AssetImage('$imagesFilePath/ended.png');

  AppImages._();
}
