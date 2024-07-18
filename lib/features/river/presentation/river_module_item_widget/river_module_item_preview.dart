import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item.dart';
import 'package:loopcare_frontend/features/river/presentation/utils/river_utils.dart';

class RiverModuleItemPreview extends StatelessWidget with RiverUtils {
  final RiverModuleItem item;
  final double radius;

  @override
  final bool isBeginning;

  const RiverModuleItemPreview({
    super.key,
    required this.item,
    required this.radius,
    this.isBeginning = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2 * radius,
      width: 2 * radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: getBackgroundColor(item),
        boxShadow: const [BoxShadow(
          color: Colors.black26,
          blurRadius: 2.0,
          offset: Offset(0.0, 2.0),
        )],
      ),
      child: Icon(
        item.icon,
        color: getIconColor(item),
        size: radius * 1.44,
      ),
    );
  }
}
