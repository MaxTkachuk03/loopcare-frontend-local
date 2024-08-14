import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item.dart';
import 'package:loopcare_frontend/features/river/infrastructure/blue_river_module_item_state.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_module_item_state.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_module_stream_type.dart';

const double kRiverOverviewItemRadius = 18.0;
const double kRiverRootItemRadius = 36.0;
const double kRiverItemRadius = 25.0;

mixin RiverUtils {
  @mustBeOverridden
  bool get isBeginning => false;

  int getIndex(int i) => i <= 5 ? i : getIndex(i - 5);

  Color getIconColor(
    RiverModuleItemState state,
    RiverModuleStreamType streamType, [
    isRootItem = false,
  ]) {
    if (isBeginning && !isRootItem) {
      return BlueRiverModuleItemState.iconColor(state);
    } else {
      return state.iconColor(streamType);
    }
  }

  Color getBackgroundColor(
    RiverModuleItemState state,
    RiverModuleStreamType streamType, [
    isRootItem = false,
  ]) {
    if (isBeginning && !isRootItem) {
      return BlueRiverModuleItemState.backgroundColor(state);
    } else {
      return state.bgColor(streamType);
    }
  }

  double itemRadius({bool isRoot = false, bool isOverview = false}) {
    if (isOverview) {
      return kRiverOverviewItemRadius;
    } else if (isRoot) {
      return kRiverRootItemRadius;
    } else {
      return kRiverItemRadius;
    }
  }
}
