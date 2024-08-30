import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImages {
  static const String imagesFilePath = 'assets/images';

  static const AssetImage recipePlaceholder = AssetImage('$imagesFilePath/recipe_placeholder.png');

  static const AssetImage sessionPlaceholder =
      AssetImage('$imagesFilePath/session_placeholder.png');

  static SvgPicture exclamationMark =
      SvgPicture.asset('$imagesFilePath/exclamation_mark.svg', fit: BoxFit.scaleDown);

  static const AssetImage intro = AssetImage('$imagesFilePath/new_intro.png');

  static const AssetImage intro2 = AssetImage('$imagesFilePath/new_intro2.png');

  static const AssetImage intro3 = AssetImage('$imagesFilePath/new_intro3.png');

  static const AssetImage physicalIntro = AssetImage('$imagesFilePath/new_physical_intro.png');

  static const AssetImage medicalIntro = AssetImage('$imagesFilePath/new_medical_intro.png');

  static const AssetImage mentalIntro = AssetImage('$imagesFilePath/new_mental_intro.png');

  static const AssetImage welcome = AssetImage('$imagesFilePath/new_welcome.png');

  static const AssetImage foodPreferences = AssetImage('$imagesFilePath/new_food_preferences.png');

  static const AssetImage logo = AssetImage('$imagesFilePath/logo.png');

  static SvgPicture oepsBig = SvgPicture.asset('$imagesFilePath/oeps.svg', width: 120, height: 120);

  static SvgPicture oepsSmall = SvgPicture.asset('$imagesFilePath/oeps.svg', width: 60, height: 60);

  static SvgPicture noConnectionBig =
      SvgPicture.asset('$imagesFilePath/no_connection.svg', width: 120, height: 120);

  static SvgPicture noConnectionSmall =
      SvgPicture.asset('$imagesFilePath/no_connection.svg', width: 60, height: 60);

  static SvgPicture calorieDensityFoodA =
      SvgPicture.asset('$imagesFilePath/calorie_dencity_food_a.svg');

  static SvgPicture calorieDensityFoodB =
      SvgPicture.asset('$imagesFilePath/calorie_dencity_food_b.svg');

  static SvgPicture bottomFrame = SvgPicture.asset('$imagesFilePath/bottom_frame.svg');

  static const AssetImage educationPreview =
      AssetImage('$imagesFilePath/new_education_preview.png');
  static SvgPicture subscriptionTop = SvgPicture.asset('$imagesFilePath/konfetti.svg');
  static const AssetImage buddyIntro = AssetImage('$imagesFilePath/buddy_intro.png');

  static const AssetImage onboardingIntro =
      AssetImage('$imagesFilePath/onboarding_intro_background.png');

  static const AssetImage onboardingIntroPrograms =
      AssetImage('$imagesFilePath/onboarding_programs.png');

  static const AssetImage onboardingIntro1 = AssetImage('$imagesFilePath/onboarding_community_maria.png');
  static const AssetImage onboardingIntro2 = AssetImage('$imagesFilePath/onboarding_medical_shalu.png');
  static const AssetImage onboardingIntro3 = AssetImage('$imagesFilePath/onboarding_activity_joshua.png');
  static const AssetImage onboardingIntro4 = AssetImage('$imagesFilePath/onboarding_nutrition_andrew.png');
  static const AssetImage onboardingIntro5 = AssetImage('$imagesFilePath/onboarding_mind_denise.png');

  static const AssetImage onboardingPacing = AssetImage('$imagesFilePath/onboarding_pacing.png');

  static SvgPicture onboardingArrow = SvgPicture.asset('$imagesFilePath/onboarding_arrow.svg');
  static SvgPicture subscriptionCross = SvgPicture.asset('$imagesFilePath/subscription_cross.svg');
 AppImages._();
}
