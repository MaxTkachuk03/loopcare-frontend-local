import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

mixin StreamColorMapper {
  Color get regularColor => switch (this) {
        RiverModuleStreamType.psychology => AppColors.petrolRegular,
        RiverModuleStreamType.nutrition => AppColors.greenRegular,
        RiverModuleStreamType.physicalActivity => AppColors.yellowRegular,
        RiverModuleStreamType.medical => AppColors.coralRegular,
        RiverModuleStreamType.community => AppColors.orangeRegular,
        StreamColorMapper() => AppColors.orangeRegular,
      };

  Color get lightestColor => switch (this) {
        RiverModuleStreamType.psychology => AppColors.petrolLightest,
        RiverModuleStreamType.nutrition => AppColors.greenLightest,
        RiverModuleStreamType.physicalActivity => AppColors.yellowLightest,
        RiverModuleStreamType.medical => AppColors.coralLightest,
        RiverModuleStreamType.community => AppColors.orangeLightest,
        StreamColorMapper() => AppColors.orangeLightest,
      };
  Color get lighterColor => switch (this) {
        RiverModuleStreamType.psychology => AppColors.petrolLighter,
        RiverModuleStreamType.nutrition => AppColors.greenLighter,
        RiverModuleStreamType.physicalActivity => AppColors.yellowLighter,
        RiverModuleStreamType.medical => AppColors.coralLighter,
        RiverModuleStreamType.community => AppColors.orangeLighter,
        StreamColorMapper() => AppColors.orangeLighter,
      };

  Color get offRegularColor => switch (this) {
        RiverModuleStreamType.psychology => AppColors.petrolOffRegular,
        RiverModuleStreamType.nutrition => AppColors.greenOffRegular,
        RiverModuleStreamType.physicalActivity => AppColors.yellowOffRegular,
        RiverModuleStreamType.medical => AppColors.coralOffRegular,
        RiverModuleStreamType.community => AppColors.orangeOffRegular,
        StreamColorMapper() => AppColors.orangeOffRegular,
      };
}

enum RiverModuleStreamType with StreamColorMapper {
  psychology,
  nutrition,
  physicalActivity,
  medical,
  community;

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
