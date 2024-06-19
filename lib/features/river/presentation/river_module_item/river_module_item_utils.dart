import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons_data.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/river/presentation/widgets/river_module_view.dart';

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

enum RiverModuleItemState {
  lock,
  unlock,
  read,
  completed;

  const RiverModuleItemState();

  bool get isCompleted => this == completed;

  bool get isUnlock => this == unlock;

  bool get isRead => this == read;

  bool get isLock => this == lock;

  Color bgColor(RiverStreamType streamType) {
    switch (this) {
      case RiverModuleItemState.lock:
        return AppColors.blueLighter;
      case RiverModuleItemState.unlock:
        return streamType.lighterColor;
      case RiverModuleItemState.read:
      case RiverModuleItemState.completed:
        return streamType.streamColor;
    }
  }

  Color iconColor(RiverStreamType streamType) {
    switch (this) {
      case RiverModuleItemState.unlock:
        return streamType.streamColor;
      case RiverModuleItemState.lock:
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
      case RiverModuleItemState.lock:
        return 0;
    }
  }
}
