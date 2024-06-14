import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons_data.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

enum RiverModuleItemState { disable, unlock, read, completed }

extension RiverModuleItemStateExt on RiverModuleItemState {
  Color getIconColor(Color contentColor) {
    if (this == RiverModuleItemState.unlock) {
      return contentColor;
    }
    return AppColors.white;
  }

  Color getBackgroundColor(Color contentColor) {
    if (this == RiverModuleItemState.unlock) {
      return contentColor.withOpacity(0.5);
    } else if (this == RiverModuleItemState.read || this == RiverModuleItemState.completed) {
      return contentColor;
    }
    return AppColors.blueLighter;
  }

  int getIconShadow() {
    if (this == RiverModuleItemState.unlock) {
      return 4;
    } else if (this == RiverModuleItemState.read) {
      return 4;
    } else {
      return 0;
    }
  }
}

enum RiverModuleItemType {
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
}

extension RiverModuleItemTypeExt on RiverModuleItemType {
  bool get isActivity => this == RiverModuleItemType.activity;

  IconData getIcon() {
    if (this == RiverModuleItemType.activity) {
      return AppIconsData.iActivity;
    } else if (this == RiverModuleItemType.assignment) {
      return AppIconsData.iAssignment;
    } else if (this == RiverModuleItemType.buddy) {
      return AppIconsData.iAssignment;
    } else if (this == RiverModuleItemType.community) {
      return AppIconsData.iAssignment;
    } else if (this == RiverModuleItemType.education) {
      return AppIconsData.iAssignment;
    } else if (this == RiverModuleItemType.goal) {
      return AppIconsData.iAssignment;
    } else if (this == RiverModuleItemType.medical) {
      return AppIconsData.iAssignment;
    } else if (this == RiverModuleItemType.mind) {
      return AppIconsData.iAssignment;
    } else if (this == RiverModuleItemType.mood) {
      return AppIconsData.iAssignment;
    } else if (this == RiverModuleItemType.nutrition) {
      return AppIconsData.iAssignment;
    } else if (this == RiverModuleItemType.weight) {
      return AppIconsData.iAssignment;
    } else if (this == RiverModuleItemType.profile) {
      return AppIconsData.iAssignment;
    } else {
      return AppIconsData.iPractice;
    }
  }
}
