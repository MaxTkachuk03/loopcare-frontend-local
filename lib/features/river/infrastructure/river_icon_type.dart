import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons_data.dart';

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
