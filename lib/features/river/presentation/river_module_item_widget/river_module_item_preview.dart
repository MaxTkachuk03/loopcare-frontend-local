import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item.dart';
import 'package:loopcare_frontend/features/river/presentation/utils/river_utils.dart';

class RiverModuleItemPreview extends StatelessWidget with RiverUtils {
  final RiverModuleItem item;
  final double radius;
  final double elevation;
  final Color? backgroundColor;
  final Color? iconColor;

  @override
  final bool isBeginning;

  const RiverModuleItemPreview({
    super.key,
    required this.item,
    required this.radius,
    this.isBeginning = false,
    this.elevation = 4.0,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      color: backgroundColor ?? getBackgroundColor(item.states.itemState, item.streamType),
      elevation: elevation,
      child: SizedBox.square(
        dimension: 2 * radius,
        child: Icon(
          item.icon,
          color: iconColor ?? getIconColor(item.states.itemState, item.streamType),
          size: radius * 1.44,
        ),
      ),
    );
  }
}
