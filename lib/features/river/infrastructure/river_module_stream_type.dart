import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

enum RiverModuleStreamType {
  psychology,
  nutrition,
  physicalActivity,
  medical,
  community;

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
