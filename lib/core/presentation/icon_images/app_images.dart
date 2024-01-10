import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImages {
  static const String imagesFilePath = 'assets/images';

  static const AssetImage logo = AssetImage('$imagesFilePath/logo.png');
  static const AssetImage introOne = AssetImage('$imagesFilePath/intro_one.png');
  static const AssetImage introTwo = AssetImage('$imagesFilePath/intro_two.png');
  static const AssetImage introThree = AssetImage('$imagesFilePath/intro_three.png');
  static const AssetImage coffee = AssetImage('$imagesFilePath/coffee.png');
  static const AssetImage preferencesDiabetes = AssetImage('$imagesFilePath/diabetes.png');
  static const AssetImage editButton = AssetImage('$imagesFilePath/edit_button.png');
  static const AssetImage reflectionActivities = AssetImage('$imagesFilePath/reflection_activities.png');

  static const AssetImage reflectionMind = AssetImage('$imagesFilePath/reflection_mind.png');

  static const AssetImage reflectionNutrition = AssetImage('$imagesFilePath/reflection_nutrition.png');

  static const AssetImage videoSession = AssetImage('$imagesFilePath/video_session.png');

  static const AssetImage nutritionTable = AssetImage('$imagesFilePath/nutrition_table.png');

  static const AssetImage reflectionWeight = AssetImage('$imagesFilePath/reflection_weight.png');

  static const AssetImage reflectionActivitiesTable =
      AssetImage('$imagesFilePath/reflection_activities_table.png');

  static const AssetImage youAndFoodIntro = AssetImage('$imagesFilePath/you_and_food_intro.png');

  static const AssetImage physicalActivitiesIntro =
      AssetImage('$imagesFilePath/physical_activities_intro.png');

  static const AssetImage selfHelpIntro = AssetImage('$imagesFilePath/self_help_intro.png');

  static const AssetImage clock = AssetImage('$imagesFilePath/clock.png');

  static const AssetImage questionMark = AssetImage('$imagesFilePath/question.png');

  static const AssetImage emptyMeal = AssetImage('$imagesFilePath/empty_meal.png');

  static const AssetImage dashboardBg = AssetImage('$imagesFilePath/dashboard_bg.png');

  static const AssetImage exploreFaces = AssetImage('$imagesFilePath/explore_faces.png');

  static const AssetImage play = AssetImage('$imagesFilePath/play.png');

  static const AssetImage arrowHexagon = AssetImage('$imagesFilePath/arrow_hexagon.png');

  static const AssetImage educationDashboard = AssetImage('$imagesFilePath/education_dashboard.png');

  static const AssetImage iconAttention = AssetImage('$imagesFilePath/attention.png');

  static const AssetImage educationVideoPreview = AssetImage('$imagesFilePath/education_video_preview.png');

  static const AssetImage recipePlaceholder = AssetImage('$imagesFilePath/recipe_placeholder.png');

  static const AssetImage lessonComplete = AssetImage('$imagesFilePath/lesson_complete.png');

  static const AssetImage oeps = AssetImage('$imagesFilePath/oeps.png');
  static const AssetImage reflectionGradient = AssetImage('$imagesFilePath/reflection_gradient.png');

  static const AssetImage noConnection = AssetImage('$imagesFilePath/no_connection.png');

  static SvgPicture logoSvgBig = SvgPicture.asset('$imagesFilePath/logo.svg', width: 114, height: 107);

  static SvgPicture logoSvgMedium = SvgPicture.asset('$imagesFilePath/logo.svg', width: 77, height: 71);

  static SvgPicture checkMarkGreen = SvgPicture.asset(
    '$imagesFilePath/check_mark_green.svg',
    width: 50,
    height: 50,
  );

  static SvgPicture checkMarkDarkGreen = SvgPicture.asset(
    '$imagesFilePath/check_mark_darkgreen.svg',
    width: 50,
    height: 50,
  );

  static SvgPicture exclamationMark = SvgPicture.asset(
    '$imagesFilePath/exclamation_mark.svg',
    fit: BoxFit.scaleDown,
  );

  static SvgPicture like = SvgPicture.asset(
    '$imagesFilePath/like.svg',
    width: 50,
    height: 50,
  );

  // TODO new assets go under this comment

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

  AppImages._();
}
