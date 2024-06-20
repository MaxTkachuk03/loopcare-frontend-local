import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

enum RiverModuleStreamType {
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

  int get streamIndex => switch (this) {
        physicalActivity => 0,
        community => 1,
        medical => 2,
        psychology => 3,
        nutrition => 4,
      };

  Color get streamColor {
    switch (this) {
      case RiverModuleStreamType.psychology:
        return AppColors.petrolRegular;
      case RiverModuleStreamType.nutrition:
        return AppColors.greenRegular;
      case RiverModuleStreamType.physicalActivity:
        return AppColors.yellowRegular;
      case RiverModuleStreamType.medical:
        return AppColors.coralRegular;
      case RiverModuleStreamType.community:
        return AppColors.orangeRegular;
    }
  }

  Color get lighterColor {
    switch (this) {
      case RiverModuleStreamType.psychology:
        return AppColors.petrolLightest;
      case RiverModuleStreamType.nutrition:
        return AppColors.greenLightest;
      case RiverModuleStreamType.physicalActivity:
        return AppColors.yellowLightest;
      case RiverModuleStreamType.medical:
        return AppColors.coralLightest;
      case RiverModuleStreamType.community:
        return AppColors.orangeLightest;
    }
  }
}
