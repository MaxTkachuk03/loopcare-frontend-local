import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item_animation_state.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';

enum RiverModuleItemState {
  locked,
  unlocked,
  read,
  completed;

  const RiverModuleItemState();

  bool get isLocked => this == locked;

  bool get isUnLocked => this == unlocked;

  bool get isRead => this == read;

  bool get isCompleted => this == completed;

  bool get isUnLockedOrHigher => !isLocked;

  bool get isReadOrHigher => isRead || isCompleted;

  RiverModuleItemState get nextState => switch (this) {
        locked => RiverModuleItemState.unlocked,
        unlocked => RiverModuleItemState.read,
        _ => RiverModuleItemState.completed,
      };

  Color bgColor(RiverModuleStreamType streamType) {
    switch (this) {
      case RiverModuleItemState.locked:
        return AppColors.blueLighter;
      case RiverModuleItemState.unlocked:
        return streamType.lightestColor;
      case RiverModuleItemState.read:
      case RiverModuleItemState.completed:
        return streamType.regularColor;
    }
  }

  Color iconColor(RiverModuleStreamType streamType) {
    switch (this) {
      case RiverModuleItemState.unlocked:
        return streamType.regularColor;

      case RiverModuleItemState.locked:
        return AppColors.blueLightest;
      case RiverModuleItemState.read:
      case RiverModuleItemState.completed:
        return streamType.lightestColor;
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

  RiverModuleItemAnimationState transformAnimationState(RiverModuleItemState nextState) {
    if (nextState.isUnLockedOrHigher && isLocked) {
      return RiverModuleItemAnimationState.unlock;
    } else if (nextState.isReadOrHigher && isUnLocked) {
      return RiverModuleItemAnimationState.read;
    } else if (nextState.isCompleted && isRead) {
      return RiverModuleItemAnimationState.complete;
    } else if (nextState.isRead && isCompleted) {
      return RiverModuleItemAnimationState.reversCompletion;
    } else if (nextState.isUnLocked && isUnLocked) {
      return RiverModuleItemAnimationState.idling;
    } else {
      return RiverModuleItemAnimationState.no;
    }
  }
}
