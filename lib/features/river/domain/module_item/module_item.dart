import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/river/presentation/river_module_item/river_module_item_utils.dart';
import 'package:loopcare_frontend/features/river/presentation/widgets/river_module_view.dart';

class ModuleItem {
  final RiverModuleItemState state;
  final RiverIconType iconType;
  final RiverStreamType stream;
  final Offset offset;

  ModuleItem({required this.state, required this.iconType, required this.stream, required this.offset,});

  Color get bgColor => state.bgColor(stream);

  IconData get icon => iconType.icon;

  Color get iconColor => state.iconColor(stream);

  double get iconElevation => state.elevation;

  bool get isReflection => iconType.isReflection;

  bool get isCompleted => state.isCompleted;

  bool get isUnlock => state.isUnlock;

  bool get isRead => state.isRead;

  bool get isLock => state.isLock;
}
