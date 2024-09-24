import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

mixin StreamColorMapper {
  Color get regularColor => switch (this) {
        RiverModuleStreamType.psychology => AppColors.petrolRegular,
        RiverModuleStreamType.nutrition => AppColors.greenRegular,
        RiverModuleStreamType.physicalActivity => AppColors.yellowRegular,
        RiverModuleStreamType.medical => AppColors.coralRegular,
        RiverModuleStreamType.community => AppColors.orangeRegular,
        StreamColorMapper() => AppColors.blueRegular,
      };

  Color get lightestColor => switch (this) {
        RiverModuleStreamType.psychology => AppColors.petrolLightest,
        RiverModuleStreamType.nutrition => AppColors.greenLightest,
        RiverModuleStreamType.physicalActivity => AppColors.yellowLightest,
        RiverModuleStreamType.medical => AppColors.coralLightest,
        RiverModuleStreamType.community => AppColors.orangeLightest,
        StreamColorMapper() => AppColors.blueLightest,
      };
  Color get lighterColor => switch (this) {
        RiverModuleStreamType.psychology => AppColors.petrolLighter,
        RiverModuleStreamType.nutrition => AppColors.greenLighter,
        RiverModuleStreamType.physicalActivity => AppColors.yellowLighter,
        RiverModuleStreamType.medical => AppColors.coralLighter,
        RiverModuleStreamType.community => AppColors.orangeLighter,
        StreamColorMapper() => AppColors.blueLighter,
      };

  Color get offRegularColor => switch (this) {
        RiverModuleStreamType.psychology => AppColors.petrolOffRegular,
        RiverModuleStreamType.nutrition => AppColors.greenOffRegular,
        RiverModuleStreamType.physicalActivity => AppColors.yellowOffRegular,
        RiverModuleStreamType.medical => AppColors.coralOffRegular,
        RiverModuleStreamType.community => AppColors.orangeOffRegular,
        StreamColorMapper() => AppColors.blueOffRegular,
      };
}

enum RiverModuleStreamType with StreamColorMapper {
  psychology,
  nutrition,
  physicalActivity,
  medical,
  community;

  String get label {
    switch (this) {
      case RiverModuleStreamType.psychology:
        return LocalizedTexts.psychology.tr().capitalize();
      case RiverModuleStreamType.nutrition:
        return LocalizedTexts.nutrition.tr().capitalize();
      case RiverModuleStreamType.physicalActivity:
        return LocalizedTexts.physicalActivity.tr().capitalize();
      case RiverModuleStreamType.medical:
        return LocalizedTexts.medical.tr().capitalize();
      case RiverModuleStreamType.community:
        return LocalizedTexts.community.tr().capitalize();
    }
  }

  bool get isPsychology => this == psychology;

  bool get isNutrition => this == nutrition;

  bool get isPhysicalActivity => this == physicalActivity;

  bool get isMedical => this == medical;

  bool get isCommunity => this == community;

  CustomAppBarTextTheme get appBarTextTheme => switch (this) {
        (RiverModuleStreamType t) when t.isPsychology => CustomAppBarTextTheme.light,
        (_) => CustomAppBarTextTheme.dark,
      };

  int get streamIndex => switch (this) {
        physicalActivity => 0,
        community => 1,
        medical => 2,
        psychology => 3,
        nutrition => 4,
      };
}
