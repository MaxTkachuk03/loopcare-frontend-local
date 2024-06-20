import 'package:flutter/cupertino.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/river/presentation/river_module_item_widget/river_module_item_widget.dart';

class LockedModuleItemWidget extends StatelessWidget {
  final Color iconColor;
  final Color bgColor;
  final double circleRadius;
  final double sizeIcon;
  final IconData icon;
  final Function()? onTap;


  const LockedModuleItemWidget({super.key,
    required this.iconColor,
    required this.bgColor,
    required this.icon,
    this.onTap,
    this.circleRadius = 25,
    this.sizeIcon = 36,});

  @override
  Widget build(BuildContext context) {
    return RiverModuleItemWidget(
      elevation: 0,
      onTap: onTap,
      circleRadius: circleRadius,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.greyLight.withOpacity(0.1),
              spreadRadius: 1.5,
              blurRadius: 1,
            ),
          ],
        ),
        width: 2 * circleRadius,
        height: 2 * circleRadius,
        child: Icon(
          icon,
          color: iconColor,
          size: sizeIcon,
        ),
      ),
    );
  }


}