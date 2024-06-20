import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_module_stream_type.dart';

enum RiverModuleItemState {
  locked,
  unlocked,
  read,
  completed;

  const RiverModuleItemState();

  bool get isCompleted => this == completed;

  Color bgColor(RiverModuleStreamType streamType) {
    switch (this) {
      case RiverModuleItemState.locked:
        return AppColors.blueLighter;
      case RiverModuleItemState.unlocked:
        return streamType.lighterColor;
      case RiverModuleItemState.read:
      case RiverModuleItemState.completed:
        return streamType.streamColor;
    }
  }

  Color iconColor(RiverModuleStreamType streamType) {
    switch (this) {
      case RiverModuleItemState.unlocked:
        return streamType.streamColor;

      case RiverModuleItemState.locked:
        return AppColors.blueLightest;
      case RiverModuleItemState.read:
      case RiverModuleItemState.completed:
        return streamType.lighterColor;
    }
  }

  double get elevation {
    switch (this) {
      case RiverModuleItemState.unlocked:
      case RiverModuleItemState.read:
      case RiverModuleItemState.completed:
        return 4;
      case RiverModuleItemState.locked:
        return 0;
    }
  }
}
