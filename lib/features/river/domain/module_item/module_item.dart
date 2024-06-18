import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/river/presentation/river_module_item/river_module_item_utils.dart';

class ModuleItem {
  final RiverModuleItemState state;
  final RiverIconType iconType;
  final RiverModuleStreamType stream;

  ModuleItem({required this.state, required this.iconType, required this.stream});

  Color get bgColor => state.bgColor(stream);

  IconData get icon => iconType.icon;

  Color get iconColor => state.iconColor(stream);

  double get iconElevation => state.elevation;

  bool get isActivity => iconType.isActivity;

  bool get isCompleted => state.isCompleted;

  Widget get activityIcon => state.activityIcon;
}
