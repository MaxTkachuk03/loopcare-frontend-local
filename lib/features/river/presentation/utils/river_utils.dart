import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item.dart';
import 'package:loopcare_frontend/features/river/infrastructure/blue_river_module_item_state.dart';

const double kRiverOverviewItemRadius = 18.0;
const double kRiverRootItemRadius = 36.0;
const double kRiverItemRadius = 25.0;

mixin RiverUtils {
  @mustBeOverridden
  bool get isBeginning => false;

  int getIndex(int i) => i <= 5 ? i : getIndex(i - 5);

  Color getIconColor(RiverModuleItem item) {
    if (isBeginning && !item.isRootItem) {
      return BlueRiverModuleItemState.iconColor(item.states.itemState);
    } else {
      return item.states.itemState.iconColor(item.streamType);
    }
  }

  Color getBackgroundColor(RiverModuleItem item) {
    if (isBeginning && !item.isRootItem) {
      return BlueRiverModuleItemState.backgroundColor(item.states.itemState);
    } else {
      return item.states.itemState.bgColor(item.streamType);
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
