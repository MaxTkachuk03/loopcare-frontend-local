import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons_data.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

enum RiverIconType {
  activity,
  assignment,
  buddy,
  community,
  education,
  goal,
  medical,
  mind,
  mood,
  nutrition,
  weight,
  profile,
  practice;

  bool get isActivity => this == activity;

  IconData get icon {
    switch (this) {
      case RiverIconType.activity:
        return AppIconsData.iActivity;
      case RiverIconType.assignment:
        return AppIconsData.iAssignment;
      case RiverIconType.buddy:
        return AppIconsData.iBuddy;
      case RiverIconType.community:
        return AppIconsData.iCommunity;
      case RiverIconType.education:
        return AppIconsData.iEducation;
      case RiverIconType.goal:
        return AppIconsData.iGoal;
      case RiverIconType.medical:
        return AppIconsData.iMedical;
      case RiverIconType.mind:
        return AppIconsData.iMind;
      case RiverIconType.mood:
        return AppIconsData.iMood;
      case RiverIconType.nutrition:
        return AppIconsData.iNutrition;
      case RiverIconType.weight:
        return AppIconsData.iWeight;
      case RiverIconType.profile:
        return AppIconsData.iProfile;
      case RiverIconType.practice:
        return AppIconsData.iPractice;
    }
  }
}

enum RiverModuleStreamType {
  psychology,
  nutrition,
  activity,
  medical,
  community;

  Color get streamColor {
    switch (this) {
      case RiverModuleStreamType.psychology:
        return AppColors.petrolRegular;
      case RiverModuleStreamType.nutrition:
        return AppColors.greenRegular;
      case RiverModuleStreamType.activity:
        return AppColors.yellowRegular;
      case RiverModuleStreamType.medical:
        return AppColors.coralRegular;
      case RiverModuleStreamType.community:
        return AppColors.orangeRegular;
    }
  }

  Color get lighterColor {
    switch (streamColor) {
      case AppColors.petrolRegular:
        return AppColors.petrolLightest;
      case AppColors.greenRegular:
        return AppColors.greenLightest;
      case AppColors.yellowRegular:
        return AppColors.yellowLightest;
      case AppColors.coralRegular:
        return AppColors.coralLightest;
      default:
        return AppColors.orangeLightest;
    }
  }
}

enum RiverModuleItemState {
  disable,
  unlock,
  read,
  completed;

  const RiverModuleItemState();

  bool get isCompleted => this == completed;

  Color bgColor(RiverModuleStreamType streamType) {
    switch (this) {
      case RiverModuleItemState.disable:
        return AppColors.blueLighter;
      case RiverModuleItemState.unlock:
        return streamType.lighterColor;
      case RiverModuleItemState.read:
      case RiverModuleItemState.completed:
        return streamType.streamColor;
    }
  }

  Color iconColor(RiverModuleStreamType streamType) {
    switch (this) {
      case RiverModuleItemState.unlock:
        return streamType.streamColor;
      case RiverModuleItemState.disable:
      case RiverModuleItemState.read:
      case RiverModuleItemState.completed:
        return streamType.lighterColor;
    }
  }

  double get elevation {
    switch (this) {
      case RiverModuleItemState.unlock:
      case RiverModuleItemState.read:
      case RiverModuleItemState.completed:
        return 4;
      case RiverModuleItemState.disable:
        return 0;
    }
  }

  Widget get activityIcon {
    switch (this) {
      case RiverModuleItemState.unlock:
        return AppIcons.iReflectionUnlock;
      case RiverModuleItemState.disable:
        return AppIcons.iReflectionDisable;
      case RiverModuleItemState.completed:
      case RiverModuleItemState.read:
        return AppIcons.iReflectionCompleted;
    }
  }
}
