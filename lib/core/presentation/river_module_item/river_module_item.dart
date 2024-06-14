import 'package:flutter/cupertino.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/river_module_item/river_module_item_utils.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

const circleRadius = 25.0;
const sizeBadge = 15.0;
const sizeIcon = 36.0;

class RiverModuleItem extends StatelessWidget {
  final RiverModuleItemState state;
  final Color contentColor;
  final RiverModuleItemType iconType;
  final Function()? onTap;

  const RiverModuleItem({
    super.key,
    required this.state,
    required this.contentColor,
    required this.iconType,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final child = Material(
      elevation: state.getIconShadow(),
      borderRadius: const BorderRadius.all(Radius.circular(circleRadius)),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: state.getBackgroundColor(contentColor),
            shape: BoxShape.circle,
            // boxShadow:  [
            //   BoxShadow(
            //     color: state.getBackgroundColor(contentColor),
            //     spreadRadius: 1.5,
            //     blurRadius: 1,
            //   ),
            // ],
          ),
          width: 2* circleRadius,
          height: 2* circleRadius,
          child:  Icon(
            iconType.getIcon(),
            color: state.getIconColor(contentColor),
            size: sizeIcon,
          ),
        ),
      ),
    );

    if (state.name == RiverModuleItemState.completed.name) {
      return badge.Badge(
        badgeStyle: const badge.BadgeStyle(
          padding: EdgeInsets.all(5),
          badgeColor: AppColors.blueRegular,
          elevation: 0,
        ),
        badgeAnimation: const badge.BadgeAnimation.slide(toAnimate: false),
        position: badge.BadgePosition.topEnd(top: -8, end: -4),
        badgeContent: const Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Icon(
            Icons.check,
            color: AppColors.white,
            size: sizeBadge,
          ),
        ),
        child: child,
      );
    } else {
      return child;
    }
  }
}

// RiverModuleItem(
// state: RiverModuleItemState.read,
// contentColor: AppColors.greenRegular,
// iconType: RiverModuleItemType.nutrition,
// ),
