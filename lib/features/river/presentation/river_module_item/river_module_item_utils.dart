import 'package:flutter/material.dart';
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
  practice,
  reflection;

  bool get isReflection => this == reflection;

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
      case RiverIconType.reflection:
        return AppIconsData.iPractice;
    }
  }
}

enum RiverModuleStreamType {
  beginning,
  psychology,
  nutrition,
  activity,
  medical,
  community;

  bool get isActivity => this == activity;

  bool get isCommunity => this == community;

  bool get isPsychology => this == psychology;

  bool get isMedical => this == medical;

  bool get isNutrition => this == nutrition;

  int get streamIndex => switch(this) {
    activity => 0,
    community => 1,
    psychology => 2,
    medical => 3,
    nutrition => 4,
    _ => -1,
  };

  Color get streamColor {
    switch (this) {
      case RiverModuleStreamType.beginning:
        return AppColors.blueRegular;
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
    switch (this) {
      case RiverModuleStreamType.beginning:
        return AppColors.blueLightest;
      case RiverModuleStreamType.psychology:
        return AppColors.petrolLightest;
      case RiverModuleStreamType.nutrition:
        return AppColors.greenLightest;
      case RiverModuleStreamType.activity:
        return AppColors.yellowLightest;
      case RiverModuleStreamType.medical:
        return AppColors.coralLightest;
      case RiverModuleStreamType.community:
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
        return AppColors.blueLightest;
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
}
